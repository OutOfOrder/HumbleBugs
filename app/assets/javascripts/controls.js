var Controls = {
    _controls: {},
    Setup: function(parent) {
        var c, $parent = (parent === undefined) ? $(document) : $(parent);

        for (c in Controls._controls) {
            Controls._controls[c]($parent);
        }
    },
    Register: function(name, func)
    {
        if ($.isFunction(func)) {
            Controls._controls[name] = func;
        }
    }
};

$(function() {
    Controls.Setup(document);
})