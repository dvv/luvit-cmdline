require('../')

local exports = { }

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
  exports[#exports + 1] = function (test)
    test.equal({ opts, args }, expected)
    test.done()
  end
end

return exports
