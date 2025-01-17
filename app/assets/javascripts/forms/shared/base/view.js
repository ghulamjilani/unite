(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Forms.View = (function(superClass) {
    extend(View, superClass);

    function View() {
      return View.__super__.constructor.apply(this, arguments);
    }

    return View;

  })(Backbone.View);

  _.extend(Forms.View, Forms.Mixins);

}).call(this);
