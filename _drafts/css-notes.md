---
layout: post
title: CSS and Sass Notes
category: blog
tags: [css, compass, sass]
excerpt: I can't memorize 30 separate CSS selectors, unless they're organized.
---

<!--more-->
## CSS Selectors
I found a set of 30 CSS selectors in the article "[The 30 CSS Selectors You Must Memorize](http://code.tutsplus.com/tutorials/the-30-css-selectors-you-must-memorize--net-16048)." I can't memorize 30 separate items easily, but these selectors can be classified into coherent groups. First, here's the list of all 30 selectors from the article:

1. `*`: `universal`
2. `#X`: `id`
3. `.X`: `class`
4. `X Y`: `descendant`
5. `X`: `type`
6. `X:visited and X:link`: pseudo-classes
7. `X + Y`: `adjacent`
8. `X > Y`: direct-child-of
9. `X ~ Y`: `sibling combinator`
10. `X[title]`: `attributes`
11. `X[href="foo"]`: `attributes`
12. `a[href*="example"]`: `attributes`
13. `a[href^="http"]`: `attributes`
14. `a[href$=".jpg"]`: `attributes`
15. `X[data-*="foo"]`: `custom attributes`
16. `X[foo~="bar"]`: `attributes`
17. `X:checked`: `pseudo-class`
18. `X:after`: `pseudo-class`
19. `X:hover`: `pseudo-class` (for a user action)
20. `X:not(selector)`: `pseudo-class` (negation)
21. `X::pseudoElement`: `pseudo-element`
22. `X:nth-child(n)`: `pseudo-class`
23. `X:nth-last-child(n)`: `pseudo-class`
24. `X:nth-of-type(n)`: `pseudo-class`
25. `X:nth-last-of-type(n)`: `pseudo-class`
26. `X:first-child`: `pseudo-class`
27. `X:last-child`: `pseudo-class`
28. `X:only-child`: `pseudo-class`
29. `X:only-of-type`: `pseudo-class`
30. `X:first-of-type`: `pseudo-class`

The Mozilla Developer's Network (MDN)

These 30 selectors fall into five groups:

- [Basic Selectors](#the-basic-css-selectors): items 1, 2, 3 and 5.
- [Cascading Selectors](#the-cascading-selectors): items 4, 7, 8 and 9.
- [Pseudo-class Selectors](#pseudo-class-selectors): items 6 and 17-20 and 22-30.
- [Attribute Selectors](#attribute-selectors): items 10-16.
- The [Pseudo-element Selector](#the-pseudo-element-selector): item 22.

There is also a selector that the article failed to mention: the grouping selector. It is one of the basic selectors, enabling you to style several selectors the same way. The syntax is `X, Y`.

I don't know yet, if there are any other selectors. I have a lot to learn, but this is certainly a good start.

### The Basic CSS Selectors
The basic selectors are:

- Universal: `*`. The asterisk selects all HTML elements.
- ID: `#X`, where `X` stands for the value of the `id` attribute of a single HTML element.
- Class: `.X`, where `X` stands for the value of the `class` attribute of the HTML elements.
- Type: `X`, where `X` is a kind of HTML element, like `p` or `h1`.
- Group: `X, Y`, where `X` and `Y` are any kind of selectors.

## The Cascading Selectors
You can set the typeface for every element on every page of the website like this:

```css
body {
    font-family: Helvetica;
}
```

Every element is a child of the `body`, so those elements will inherit the font family unless that property is overridden with a more specific rule. For example, you might want to use Georgia in the sidebar. To reset the font-family rule for the sidebar (assuming you use the `aside` element for the content in the sidebar), you can write:

```css
body aside {
    font-family: Georgia;
}
```

The article [CSS: Taking Control of the Cascade](https://signalvnoise.com/posts/3003-css-taking-control-of-the-cascade) uses this example as a warning about how complicated CSS can become. Each time we reset a style using a more specific rule, overriding that style on a subsequent child element requires an even more specific selector. The selectors become increasingly long and complicated.

To deal with this complexity, the author suggests some techniques that fall into three categories: compiled CSS, structured mark-up and what he calls "a neglected CSS selector."

Compiled CSS refers to using a CSS pre-processor or extension language, like [Sass](http:/sass-lang.com) or [Less](http://lesscss.org).

## Grouping Selectors
There are a variety of selectors, the most basic of which are HTML elements. If you want to style all paragraphs, specify the `p` element and place the CSS style properties between a pair of braces:

```css
p {
    type-family: Helvetica, serif;
    color: black;
}
```

If you want to style several elements the same way, then combine the elements (for that matter, any kinds of selectors) in a comma-separated list. The following will color all the headings blue:

```css
h1, h2, h3, h4, h5, h6 {
    color: blue;
}
```
