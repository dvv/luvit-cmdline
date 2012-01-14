#!/usr/bin/env luvit
require('./cmdline')

_G.equal = function(a, b)
  return a == b
end

_G.deep_equal = function(expected, actual, msg)
  if type(expected) == 'table' and type(actual) == 'table' then
    if #expected ~= #actual then return false end
    for k, v in pairs(expected) do
      if not deep_equal(v, actual[k]) then return false end
    end
    return true
  else
    return equal(expected, actual)
  end
end

local cases = {
[{ }] = { { }, { } },
[{ '--' }] = { { }, { } },
[{ '--foo' }] = { { foo=true }, { } },
[{ '--foo' }] = { { foo=true }, { } },
[{'foo', '--bar=bar', '--bool', '--baz=baz1', '--baz=baz2', '--baz=baz2'}] = { { bar='bar', bool=true, baz={'baz1','baz2','baz2'} }, { 'foo' } },
[{'foo', '--bar=bar', '--baz=baz1', '--', '--baz=baz2', '--baz=baz2'}] = { { bar='bar', baz='baz1' }, { 'foo', '--baz=baz2', '--baz=baz2' } },
}

for argv, expected in pairs(cases) do
  local opts, args = process.parse_argv(argv)
  --p({ opts, args }, expected)
  assert(deep_equal({ opts, args }, expected))
end
