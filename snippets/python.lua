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
    'fn',
    fmt(
      [[
      def {}(self, {}):
        {}
      ]],
      { i(1, 'fn'), c(2, { t 'args', t 'some' }), i(3, 'pass') }
    )
  ),
}
