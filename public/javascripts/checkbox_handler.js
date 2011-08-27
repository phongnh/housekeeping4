var HK;
HK = window.HK || {};
HK.CheckboxHandler = (function() {
  function CheckboxHandler(parent, child) {
    var checkAll, checkOne, isCheckAll, _child, _parent;
    if (parent == null) {
      parent = 'parent';
    }
    if (child == null) {
      child = 'child';
    }
    _parent = parent;
    _child = child;
    isCheckAll = function() {
      return 0 === jQuery(":checkbox." + _child + ":not(:checked)").length;
    };
    checkOne = function(event) {
      child = event.currentTarget;
      parent = event.data;
      parent.checked = child.checked && isCheckAll();
    };
    checkAll = function(event) {
      var children;
      parent = event.currentTarget;
      children = event.data;
      return children.each(function() {
        this.checked = parent.checked;
      });
    };
    (function() {
      parent = jQuery(":checkbox." + _parent);
      child = jQuery(":checkbox." + _child);
      parent.bind("click", child, checkAll);
      child.bind("click", parent[0], checkOne);
      if (parent[0].checked) {
        return parent[0].click();
      }
    })();
    this.getChecked = function(delimiter) {
      if (delimiter == null) {
        delimiter = ",";
      }
      return jQuery.map(jQuery(":checkbox." + _child + ":checked"), function(element) {
        return element.value;
      }).join(delimiter);
    };
  }
  return CheckboxHandler;
})();