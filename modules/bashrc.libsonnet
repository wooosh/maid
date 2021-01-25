{
  enabled: false,
  actions: [
    {path: "~/.bashrc", contents: $.envstring + $.raw}
  ],

  envstring:
    std.lines(
      std.map(function(var)
        var + "=" + self.environment[var],
        std.objectFields(self.environment)
      )
    ),

  environment: {},
  raw: ""
}
