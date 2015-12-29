// Avoid `console` errors in browsers that lack a console.
(function() {
    var method;
    var noop = function () {};
    var methods = [
        'assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
        'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
        'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
        'timeline', 'timelineEnd', 'timeStamp', 'trace', 'warn'
    ];
    var length = methods.length;
    var console = (window.console = window.console || {});

    while (length--) {
        method = methods[length];

        // Only stub undefined methods.
        if (!console[method]) {
            console[method] = noop;
        }
    }
}());

// Place any jQuery/helper plugins in here.
/*
    Plugin to make variable height divs equal heights
    Thanks to Adham Dannaway, via:
    http://www.cre8ivecommando.com/equal-height-columns-using-jquery-6164/
*/
$.fn.sameHeights = function() {
    $(this).each(function(){
    var tallest = 0;

    $(this).children().each(function(i){
        if (tallest < $(this).height()) { tallest = $(this).height(); }
    });
    $(this).children().css({'height': tallest});
});

return this;
};
