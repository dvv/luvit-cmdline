--
-- a simple command line arguments parser
--

local Table = require('table')

-- Extract options and arguments from
-- an explicit list, or `process.argv`.
-- Strings of form '--OPTION=VALUE' are parsed to { OPTION = 'VALUE' }.
-- Strings of form '--OPTION' are parsed to { OPTION = true }.
-- Multiple '--OPTION=VALUE' are merged into { OPTION = { 'VALUE', 'VALUE', ... } }.
-- Strings after separate '--' go to arguments verbatim.

-- E.g.
-- process.parse_flags({'foo', '--bool', '--bar=bar', '--baz=baz1', '--baz=baz2', '--baz=baz2'})
-- { bar = 'bar', baz = { 'baz1', 'baz2', 'baz1' }, bool = true }, { 'foo' }
-- process.parse_flags({'foo', '--bool', '--bar=bar', '--', '--baz=baz1', '--baz=baz2', '--baz=baz2'})
-- { bar = 'bar', baz = { 'baz1', 'baz2', 'baz1' }, bool = true }, { 'foo' }

function process.parse_argv(argv)
  if not argv then argv = process.argv end
  local opts = { }
  local args = { }
  for i, arg in ipairs(argv) do
    -- option?
    local opt = arg:match("^%-%-(.*)")
    if opt then
      -- extract option name and value
      local key, value = opt:match("([a-z_%-]*)=(.*)")
      --p('OPT', opt, key, value)
      -- value provided?
      if value then
        -- option seen once?
        if type(opts[key]) == 'string' then
          -- transform option to array of values
          opts[key] = { opts[key], value }
        -- options seen many times?
        elseif type(opts[key]) == 'table' then
          -- append value
          Table.insert(opts[key], value)
        -- options was not seen
        else
          -- assign value
          opts[key] = value
        end
      -- no value provided. just set option to true
      elseif opt ~= '' then
        opts[opt] = true
      -- options stop
      else
        -- copy left arguments
        for i = i + 1, #argv do
          Table.insert(args, argv[i])
        end
        break
      end
    -- argument
    else
      Table.insert(args, arg)
    end
  end
  -- report options and arguments
  return opts, args
end
