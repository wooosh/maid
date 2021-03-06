local toProp = function(prop, level=0)
  if std.isObject(prop)
  then std.flatMap(
    function(k)
      local p = toProp(prop[k], level + 1);
      if std.isArray(p)
      then std.map(function(q)
                     k + '.' + q,
                   p)
      else [(if level < 3 then '*.') + k + ': ' + p],
    std.objectFields(prop)
  )
  else prop;

{
  enabled: false,
  actions: [{ path: '~/.Xresources', contents: std.lines(toProp($.properties)) }],
  properties: {},
}
