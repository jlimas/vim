local fmt = require('luasnip.extras.fmt').fmt
local selection = require('snippets.helpers').selection

local ls = require 'luasnip'
local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local c = ls.choice_node
local f = ls.function_node

-- Insert Node (i) = i(pos, 'placeholder')
-- Choice Node (c) = c(pos, { node, node })
-- Format Node (fmt) = fmt([[ ]])
-- Function Node (f) =  f(function() return os.date '%Y-%m-%d' end)

return {
  s(
    'try',
    fmt(
      [[
      try {{
        {}
      }} catch (err) {{
        console.log('error', err)
      }}
      ]],
      { f(selection) }
    )
  ),
}
