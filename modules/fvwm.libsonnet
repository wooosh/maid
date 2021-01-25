{
  enabled: false,
  actions: [
    { path: 'fvwmrc', contents: std.lines($.commands) },
  ],

  style(name, props)::
    'Style ' + name + ' ' +
    std.join(
      ', ',
      std.map(
        function(propName)
          local propVal = props[propName];
          if std.isBoolean(propVal) then
            (if !propVal then '!') + propName
          else propName + ' ' + propVal,
        std.objectFields(props)
      )
    ),

  commands: [],
}
