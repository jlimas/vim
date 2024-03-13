local function selection(_, snip)
  local res, env = {}, snip.env
  for _, line in ipairs(env.LS_SELECT_RAW) do
    table.insert(res, line)
  end
  return res
end

return { selection = selection }
