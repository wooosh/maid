local toProp = function(prop, level = 0)
  if std.isObject(prop)
  then std.flatMap(function(k)
      local p = toProp(prop[k], level + 1);
      if std.isArray(p)
      then std.map(function(q)
        k + "." + q,
        p)
      else [(if level < 3 then "*.") + k + ': ' + p],
    std.objectFields(prop)
  )
  else prop;

{
  enabled: false,
  actions: [{type: "file", contents: std.lines(toProp($.config))}],
  xft(font)::
    std.join(":",
      ["xft", font.name] + 
      std.filterMap(
        function(prop) prop != "name",
        function(prop) prop + "=" + font[prop],
        std.objectFields(font)
      )
    ),
  config: {}
}
