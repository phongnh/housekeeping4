HK = window.HK || {}

class HK.CheckboxHandler
  constructor: (parent='parent', child='child') ->
    _parent = parent
    _child = child
    isCheckAll = ->
      0 is jQuery(":checkbox.#{_child}:not(:checked)").length
    checkOne = (event) ->
      child = event.currentTarget
      parent = event.data
      parent.checked = child.checked && isCheckAll()
      return
    checkAll = (event) ->
      parent = event.currentTarget
      children = event.data
      children.each ->
        @.checked = parent.checked
        return
    do ->
      parent = jQuery ":checkbox.#{_parent}"
      child  = jQuery ":checkbox.#{_child}"
      parent.bind "click", child, checkAll
      child.bind "click", parent[0], checkOne
      parent[0].click() if parent[0].checked

    @.getChecked = (delimiter=",") ->
      jQuery.map jQuery(":checkbox.#{_child}:checked"),
                 (element)-> element.value
        .join(delimiter).trim()

