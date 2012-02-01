CmdLine
====

A simple command line arguments parser.
----

Extracts options and arguments from an explicitly passed list, or `process.argv`.
Strings of form `'--OPTION=VALUE'` are parsed to `{ OPTION = 'VALUE' }`.
Strings of form `'--OPTION'` are parsed to `{ OPTION = true }`.
Multiple `'--OPTION=VALUE'` are merged into `{ OPTION = { 'VALUE', 'VALUE', ... } }`.

Strings after separate '--' go to arguments verbatim.

Usage
----

```lua
process.parse_argv({'foo', '--bool', '--bar=bar', '--baz=baz1', '--baz=baz2', '--baz=baz2'})
{ bar = 'bar', baz = { 'baz1', 'baz2', 'baz1' }, bool = true }, { 'foo' }

process.parse_argv({'foo', '--bool', '--bar=bar', '--', '--baz=baz1', '--baz=baz2', '--baz=baz2'})
{ bar = 'bar', baz = { 'baz1', 'baz2', 'baz1' }, bool = true }, { 'foo' }
```

License
----

[MIT](luvit-cmdline/license.txt)
