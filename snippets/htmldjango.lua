local fmt = require('luasnip.extras.fmt').fmt
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
-- local f = ls.function_node

-- Insert Node (i) = i(pos, 'placeholder')
-- Choice Node (c) = c(pos, { node, node })
-- Format Node (fmt) = fmt([[ ]])
-- Function Node (f) =  f(function() return os.date '%Y-%m-%d' end)

return {
  s(
    'url',
    fmt(
      [[
       {{% url '{}' %}}
      ]],
      { i(1, 'url') }
    )
  ),
  s(
    'static',
    fmt(
      [[
       {{% static '{}' %}}
      ]],
      { i(1, 'url') }
    )
  ),
  s(
    'include',
    fmt(
      [[
       {{% include '{}' %}}
      ]],
      { i(1, 'url') }
    )
  ),
  s(
    'load',
    fmt(
      [[
       {{% load '{}' %}}
      ]],
      { i(1, 'what?') }
    )
  ),
  s(
    'block',
    fmt(
      [[
        {{% block {} %}}
          {}
        {{% endblock %}}
      ]],
      { i(1, 'block'), i(2, '') }
    )
  ),
}
