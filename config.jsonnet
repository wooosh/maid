// TODO: make firt argument name, second argument options={}
local xft = function(font)
  std.join(
    ':',
    ['xft', font.name] +
    std.filterMap(
      function(prop) prop != 'name',
      function(prop) prop + '=' + font[prop],
      std.objectFields(font)
    )
  );

local fonts = {
  terminal: xft({ name: 'canele', pixelsize: 12 }),
  terminalBold: xft({ name: 'pretzel', pixelsize: 12 }),

  manpager: xft({ name: 'Go Mono', size: 10 }),
  manpagerBold: xft({ name: 'Go Mono', size: 10, style: 'Bold' }),

  windowTitles: xft({ name: 'Charcoal', pixelsize: 12 }),
  gtk: xft({ name: 'Monaco_15' }),
};

function(modules)
  [
    modules.bashrc {
      enabled: true,
      environment: {
        PS1: '\\W:',
        EDITOR: 'vim',
      },
      raw: |||
        xman () {
          urxvt -name manpager -e man "$1" &
        }
      |||,
    },

    modules.xresources {
      enabled: true,
      properties: {
        scrollBar: false,
        scrollBar_right: false,
        internalBorder: 8,
        URxvt: {
          // Font settings
          font: fonts.terminal,
          boldFont: fonts.terminalBold,
          letterSpace: 1,

          // TODO: asset("bg.png")
          backgroundPixmap: '/home/wooosh/bg.png',
          borderColor: '#323232',

          foreground: '#cbf3f3',
        },
      },
    },

    modules.fvwm {
      enabled: true,
      commands: [
        $.style('*', {
          StippledTitle: true,
          UseDecor: 'Main',
          Colorset: 3,
          HighlightColorset: 3,
          Font: fonts.windowTitles,
        }),
        $.style('urxvt', {
          Title: false,
          UseDecor: 'Terminal',
          Colorset: 2,
          HighlightColorset: 2,
          TitleAtBottom: true,
          HandleWidth: 16,
        }),
      ],
    },
  ]
