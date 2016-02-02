---
layout: post
title: LMAX Disruptor
category: [queues,concurency,threads,asynchronous,events,patterns,disruptor]
---
The Disruptor is a general-purpose pattern for building low-latency, high-throughput event processing queues.

<!--more-->
The Disruptor pattern was created by the [LMAX Exchange](https://www.lmax.com/) as part of their efforts to build a high performance financial exchange. They found that the compute-time in their processing pipelines were dominated by the cost of queuing of events between stages. The Disruptor is the result of their work to build a concurrent structure that separates the concerns for producers, consumers and their data storage.

## Definitions
- concurrency: two or more tasks running in parallel that contend for access to resources.
- mutual exclusion: managing contended updates to some resource.
- visibility of change: controlling when such changes are made visible to other threads.

"The most costly operation in any concurrent environment is a contended write access. To have multiple threads write to the same resource requires complex and expensive coordination. Typically this is achieved by employing a locking strategy of some kind."

## The Design of the LMAX Disruptor
- queues conflate several data-storage concerns for handling the needs of producers and consumers. The Disruptor separates these concerns.
- Ensure that any data are owned by only one thread for write access, eliminating write contention. This is the Disruptor design.
- At the heart of the disruptor is a pre-allocated bounded data structure in the form of a ring-buffer. Data is added to the ring buffer through one or more producers, and processed by one or more consumers.

### Memory Allocation and Garbage Collection
All memory for the ring buffer is pre-allocated on start up. A ring buffer can store either an array of pointers to entries, or an array of structures representing the entries. In Java, entries in ring buffers must be pointers to objects. This pre-allocation of entries eliminates issues in languages that support garbage collection, since the entries will be reused and live for the duration of the Disruptor instance.

Under heavy load queue-based systems can back up, which can lead to a reduction in the rate of processing, and results in the allocated objects surviving longer than they should, thus being promoted beyond the young generation with generational garbage collectors. This has two implications: first, the objects have to be copied between generations which cause latency jitter; second, these objects have to be collected from the old generation which is typically a much more expensive operation and increases the likelihood of “stop the world” pauses that result when the fragmented memory space requires compaction. In large memory heaps this can cause pauses of seconds per GB in duration.

### Teasing Apart the Concerns
The following concerns are conflated in all queue implementations, to the extent that this collection of distinct behaviors tend to define the interfaces that queues implement:

1. Storage if items being exchanged.
2. Coordination of producers claiming the next sequence for exchange.
3. Coordination of consumers being notified that a new item is available.

When designing a low-latency pipeline in a language that uses garbage collection, too much memory allocation can be problematic. This concern eliminates linked-list backed queues from consideration. Garbage collection is minimized if the entire storage for the exchange of data between processing stages can be pre-allocated. Furthermore, if this allocation can be performed in a uniform chunk, then traversal of that data will be done in a manner that is very friendly to the caching strategies employed by modern processors.

A data-structure that meets this requirement is an array with all the slots pre-filled. On creation of the ring buffer, the Disruptor utilizes the Abstract Factory pattern to pre-allocate the entries. When an entry is claimed, a producer can copy its data into the pre-allocated structure. I'm thinking that move-constructors and move-assignment operators are needed in a C++ implementation.

Note that the size of a ring buffer should be a power of 2 to reduce the cost of calculating the remainder on a sequence number to get the correct index.

In general, bounded queues suffer from contention at the head and tail. The ring buffer data structure is free from this contention and concurrency primitives, because these concerns have been teased out into producer and consumer barriers through which the ring buffer must be accessed. The logic for these barriers is described below:

In the case where there is only one producer (such as when the producer is reading a file or listening to a network connection), there is no contention on sequence/entry allocation. In cases where there are multiple producers, producers will race one another to claim the next entry in the ring buffer. Contention on claiming the next available entry can be managed with a simple Compare-And-Swap (CAS) operation on the sequence number for that slot.

Once a producer has copied the relevant data to the claimed entry it can make it public to consumers by committing the sequence. This can be done without CAS by a simple busy-spin until the other producers have reached this sequence in their own commit. This producer then advances the cursor signifying the next available entry for consumption. Producers can avoid wrapping the ring by tracking the sequence of the consumers as a simple read operation before they write to the ring buffer.

Consumers wait for a sequence to become available in the ring buffer before they read the entry. Various strategies can be employed while waiting. If CPU resource is precious, they can wait on a condition variable within a lock that gets signaled by the producers. This obviously is a point of contention and only to be used when CPU resource is more important than latency or throughput. The consumers can also loop, checking the cursor which represents the currently available sequence in the ring buffer. This could be done with or without a thread yield by trading CPU resource against latency. This scales very well as we have broken the contended dependency between the producers and consumers if we do not use a lock and condition variable. Lock-free multi-producer and multi-consumer queues do exist, but they require multiple CAS operations on the head, tail, and size counters. The Disruptor does not suffer this CAS contention.

### Sequencing
Sequencing is the core concept to how concurrency is managed in the Disruptor. Each producer and consumer works off of a strict sequencing concept for how it interacts with the ring buffer. Producers claim the next slot in sequence when claiming an entry in the ring. This can be a simple counter in the case of only one producer, or an atomic counter updated using CAS operations in the case of multiple producers.

Once a sequence value is claimed, this entry in the ring buffer is available to be written to by the producer that claimed it.

### The Class Diagram
<img class="article_img2" src="/img/disruptor.svg">

## References
- [A Comparison of the Disruptor](http://stackoverflow.com/questions/6559308/how-does-lmaxs-disruptor-pattern-work) on stackoverflow.
- [Getting Started with CoralQueue](http://www.coralblocks.com/index.php/2014/06/getting-started-with-coralqueue/) has a description of a Disruptor implementation.
- [Dissecting the Disruptor: Demystifying Memory Barriers](http://mechanitis.blogspot.com/2011/08/dissecting-disruptor-why-its-so-fast.html).
- [Memory Barrier](https://en.wikipedia.org/wiki/Memory_barrier) on Wikipedia.

## Quick Overview
There's a nice [comparison of the Disruptor](http://stackoverflow.com/questions/6559308/how-does-lmaxs-disruptor-pattern-work) to a queue, the Actor model and the Staged Event-Driven Architecture (SEDA) on stackoverflow, by Michael Barking. It goes as follows:

### Comparison to a Queue
The Disruptor is similar to a queue in that it enables one thread, a producer, to pass a message to other threads, the consumers, waking them up if necessary. The three differences are:

1. The user of the Disruptor defines how messages are stored by extending the Entry class interface and providing a factory to pre-allocate memory for the ring buffer. This allows for either memory reuse through copying, or an instance of the Entry class interface could contain a reference to another object.
2. Putting messages into the Disruptor is a 2-phase process. First a slot is claimed in the ring buffer, which provides the user with the Entry that can be filled with the appropriate data. Second, the entry must be committed. This 2-phase approach is necessary to allow for the flexible use of memory mentioned above. It is the commit that makes the message visible to the consumer threads.
3. It is the responsibility of the consumer to keep track of the messages that have been consumed from the ring buffer. Moving this responsibility away from the ring buffer itself helped reduce the amount of write contention as each thread maintains its own counter.

### Comparison to the Actor Model
The Disruptor is close to the Actor model, especially if you use the BatchConsumer/BatchHandler classes that are provided. These classes hide all of the complexities of maintaining the consumed sequence numbers and provide a set of simple callbacks to handle important events. However, there are a couple of subtle differences.

1. The Disruptor uses a 1-thread - 1-consumer model, where Actors use an N:M model. That is, you can have as many actors as you like and they will be distributed across a fixed number of threads (generally 1 thread per core).
2. The BatchHandler interface provides an additional (and very important) callback `onEndOfBatch()`. This allows for slow consumers. For example, those doing I/O to batch events together to improve throughput. It is possible to do batching in other Actor frameworks, however as  nearly all other frameworks don't provide a callback at the end of the batch, you need to use a timeout to determine the end of the batch, resulting in poor latency.

### Comparison to SEDA
LMAX built the Disruptor pattern to replace a SEDA-based approach.

1. The main improvement that it provided over SEDA was the ability to do work in parallel. To do this the Disruptor supports multi-casting the same messages (in the same order) to multiple consumers. This avoids the need for fork stages in the pipeline.
2. We also allow consumers to wait on the results of other consumers without having to put another queuing stage between them. A consumer can simply watch the sequence number of a consumer that it depends on. This avoids the need for join stages in the pipeline.

### Comparison to Memory Barriers
Another way to think about it is as a structured, ordered memory barrier. The producer barrier forms the write barrier and the consumer barrier is the read barrier.

Memory barriers are necessary, because modern CPUs can reorder loads and stores to optimize performance. These optimizations are normally not an issue in a single thread of execution. However, in concurrent programs and device drivers in multiprocessor systems, they can cause unpredictable results.

Memory barriers are expensive operations, so they must be used only where necessary. They invalidate CPU caches and cause the CPU to read or write main memory, which is orders of magnitude slower than the caches.

There seem to be three categories of memory barriers, also known as fences. There's the full fence, which ensures that all load and store operations before to the fence will have been committed prior to any loads and stores issued following the fence. Some architectures provide separate 'acquire' and 'release' memory barriers, which address the visibility of read-after-write operations from the point of view of a reader (sink, consumer) or a writer (source, producer), respectively.

#### Acquire and Release Semantics
NOTE: One good reference is the September 13, 2012 article [Acquire and Release Semantics](http://preshing.com/20120913/acquire-and-release-semantics/), by Jeff Preshing. Other references covering subtleties of acquire and release operations and fences (they aren't the same thing) are:

* [Acquire and Release Fences](http://preshing.com/20130922/acquire-and-release-fences/)
* [Acquire and Release Fences Don't Work the Way You'd Expect](http://preshing.com/20131125/acquire-and-release-fences-dont-work-the-way-youd-expect/)
* [Memory Barriers Are Like Source Control Operation](http://preshing.com/20120710/memory-barriers-are-like-source-control-operations/)
* [The Purpose of memory_order_consume in C++11](http://preshing.com/20140709/the-purpose-of-memory_order_consume-in-cpp11/)
* [Double-Checked Locking is Fixed in C++11](http://preshing.com/20130930/double-checked-locking-is-fixed-in-cpp11/)
* [The Synchronizes-With Relation](http://preshing.com/20130823/the-synchronizes-with-relation/)
* [Atomic vs. Non-Atomic Operations](http://preshing.com/20130618/atomic-vs-non-atomic-operations/)
* [The World's Simplest Lock-Free Hash Table](http://preshing.com/20130605/the-worlds-simplest-lock-free-hash-table/)
* [Improved Support for Bidirectional Fences](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2633.html) from the "Programming Language C++, Library/Concurrency Subgroup" on 2008-05-16.
* [Mintomic](http://mintomic.github.io/), a library provides an API for lock-free programming in C and C++ (no C++11 compilers required).
* [Lockless Programming Considerations for Xbox 360 and Microsoft Windows](https://msdn.microsoft.com/en-us/library/windows/desktop/ee418650.aspx)

An operation has /acquire/ semantics if other processors will always see its effect before any subsequent operation's effect. In other words, acquire semantics guarantee the particular operation is completed and is visible to all processors before any subsequent code is executed. It can only apply to operations which /read/ from shared memory, whether they are read-modify-write operations or plain loads. The operation is then considered a /read-acquire/. Acquire semantics prevent memory reordering of the read-acquire with any read or write operation which /follows/ it in program order.

An operation has /release/ semantics if other processors will see every preceding operation's effect before the effect of the operation itself. In other words, release semantics guarantee all previous operations will be completed and is visible to all processors before the current operation is executed. It is a property which can only apply to operations which /write/ to shared memory, whether they are read-modify-write operations or plain stores. The operation is then considered a /write-release/. Release semantics prevent memory reordering of the write-release with any read or write operation which /precedes/ it in program order.

Wow! There is a subtle difference between a release operation and a release fence. See Jeff Pershing's November 25, 2013 article [Acquire and Release Fences Don't Work the Way You'd Expect](http://preshing.com/20131125/acquire-and-release-fences-dont-work-the-way-youd-expect/), particularly the section called "Nor Can a Release Operation Take the Place of a Release Fence".

He compared the properties of a release operation:

```cpp
tmp = new Singleton;
m_instance.store(tmp, std::memory_order_release);
```

with a release fence:

```cpp
tmp = new Singleton;
std::atomic_thread_fence(std::memory_order_release);
m_instance.store(tmp, std::memory_order_relaxed);
```

Apparently, a release operation, such as the one above will only prevent preceding memory operations from being reordered past /itself/, but a release fence is more strict. The release fence must prevent preceding memory operations from being reordered past /all subsequent writes/, not just itself. Pershing goes on to show why this distinction is important. Here's his example:

```cpp
Singleton* tmp = new Singleton;
g_dummy.store(0, std::memory_order_release);
m_instance.store(tmp, std::memory_order_relaxed);
```

In this case, the store to `m_instance` is now free to be reordered before the store to `g_dummy`, and possibly before any stores performed by the `Singleton` constructor.

Full fence operations have both acquire and release semantics, so all code preceding the particular operation will be completed and be visible to all processors (release semantics), and the particular operation will be completed and be visible to all processors before any subsequent operation is executed (acquire semantics).

Consider this code:
```cpp
a++;
b++;
c++;
```

From another processor's point of view, the preceding operations can appear to occur in any order. Microsoft Windows provides `Interlocked*` functions that have both acquire and release semantics by default. Some processors, such as the Itanium-based ones, provide instructions that have only acquire or release semantics which are faster than those with both. Therefore, Windows also provides `Interlocked*Acquire` and `Interlocked*Release` version of some of the interlocked functions.

For example, the `InterlockedIncrementAcquire` routine uses acquire semantics. The code above could be rewritten as follows to ensure that other processors would always see the increment of `a` before the increments of `b` and `c` (while the increments of `b` and `c` could be in either order):

```cpp
InterlockedIncrementAcquire(&a);
b++;
c++;
```

Likewise, the `InterlockedIncrementRelease` routine uses release semantics, so we could ensure that other processors saw the increment of `c` after the increments of `a` and `b` (while the increments of `a` and `b` could still be in either order):

```cpp
a++;
b++;
InterlockedIncrementRelease(&c);
```

Note that on x86 processors, which do not have instructions that have only acquire or release semantics, both `InterlockedIncrementAcquire` and `InterlockedIncrementRelease` are equivalent to `InterlockedIncrement`.
#### The `volatile` Keyword
One warning about the C/C++ keyword `volatile`. It was intended to allow C and C++ programs to directly access memory-mapped I/O. All it does is ensure that the compiler will emit code such that reads and writes to volatile memory locations happen in the exact order specified and that no read or write is omitted (due to some compiler optimization, for example). The keyword `volatile` does /not/ guarantee a memory barrier to enforce cache consistency. It is worth reading the Linux kernel document [Why the "volatile" type class should not be used](https://www.kernel.org/doc/Documentation/volatile-considered-harmful.txt). It highlights problems with the `volatile` keyword.

### Behaviors for Consumers
Generally, consumers can read concurrently and independently. However, we can declare dependencies among consumers. Consumer dependencies can be arbitrary, forming an acyclic graph. If consumer B depends on consumer A, consumer B can't read past consumer A.

Consumer dependency arises because consumer A can annotate an entry, and consumer B depends on that annotation. For example, A does some calculation on an entry, and stores the result in field `a` of the entry. Consumer A then moves on, and now B can read the entry, and the new value of `a`. If reader C does not depend on A, C should not attempt to read `a`.

The Entry objects in the ring buffer are pre-allocated to reduce the cost of garbage collection (or of allocating and releasing memory from the head, in the case of non-garbage collected implementations). Producers and consumers don't insert new entry objects, or delete old ones. Instead, a producer asks for a pre-existing entry, populates its fields and notifies the consumers. This 2-phase action might look like this in code:

```java
setNewEntry(EntryPopulator);
interface EntryPopulator { void populate(Entry existingEntry); }
```

For developers of consumers, note that different annotating consumers should write to different fields to avoid write contention. Actually, they should write to different cache lines. An annotating consumer should not touch anything that other non-dependent consumers may read. This is why we say /annotate/ entries instead of /modify/ entries.

### Another Explanation of Producers and Consumers
The ring buffer of Entry objects has a sister buffer that amounts to an array (ring buffer) of flags. This flag array is the same size as the ring buffer. Each flag is an integer that indicates the availability of the associated slot in the ring buffer.

There can be any number of producers. When one wants to write to the buffer, it gets the current write position from the buffer and increments it atomically with a Compare And Set instruction, along the lines of the following code:

```java
public final int incrementAndGet() {
    for (;;) {
        int current = get();
        int next = current + 1;
        if (compareAndSet(current, next))
            return next;
    }
}
```

We can refer to this value as a `producerCallId`. In a similar manner, a `consumerCallId` is generated when a consumer /finishes/ reading an Entry from the buffer. The most recent `consumerCallId` is accessed. If there are many consumers, the call with the lowest ID is chosen.

These IDs are compared, and if the differences between the two is less than the buffer size, the producer is allowed to write. If the `producerCallId` is greater than the recent `consumerCallId + bufferSize`, then the buffer is full and the producer must wait until an entry becomes available.

The producer is then assigned the entry in the ring buffer based on the value of its `producerCallId` (the index of the entry is `producerCallId mod bufferSize`, and since the `bufferSize` is a power of 2, the index is `producerCallId & (bufferSize - 1)`). It is then free to modify the entry at that location. The actual algorithm is a little more complicated, involving caching the most recent `consumerCallId` in a separate atomic reference for optimization purposes.

When the entry is modified, the change is "published" by updating the respective slot in the flag array. The flag value is the number of the loop (`producerCallId` divided by the `bufferSize`, or simply `producerCallId >> bufferSize`, since `bufferSize` is a power of 2).

In a similar manner, there can be any number of consumers. Each time a consumer wants to access the buffer, a `consumerCallId` is generated. Depending on how consumers were added to the Disruptor, the atomic value used to generate the ID may be shared or separate for each of them. This `consumerCallId` is then compared to the most recent `producerCallId`, and if it is less than the value of that `producerCallId`, the reader is allowed to progress. If they are the same value, then the buffer is empty and the consumer must wait. The manner of waiting is defined by the implementation of the `WaitStrategy` used during the creation of the Disruptor.

For individual consumers, the ones with their own ID generator, the next thing to check is the ability to batch consume. The slots in the buffer are examined in order from the one index by the `consumerCallId` to the one indexed by the recent `producerCallId`. They are examined in a loop by comparing the flag value written in the flag array, against a flag value generated for the consumerCallId. If the flags match it means that the producers filling the slots have committed their changes. If not, the loop is broken, and the highest committed change ID is returned. The slots from `consumerCallId` to received in change ID can be consumed in batch.

If a group of consumers read together (the ones with a shared ID generator), each one only takes a single call ID, and only the slot for that single call ID is checked and returned.
