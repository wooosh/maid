function(modules)
[
    modules.bashrc {
    enabled: true,
    environment: {
      PS1: "\\W:",
      EDITOR: "vim"
    },
    raw: |||
      xman () {
        urxvt -name manpager -e man "$1" &
      }
    |||
  },
  modules.xresources {
    enabled: true,
    properties: {
      scrollBar: false,
      scrollBar_right: false,
      internalBorder: 8,
      URxvt: {
        // Font settings
        font: $.xft({name: "canele", pixelsize: 12}),
        boldFont: $.xft({name: "pretzel", pixelsize: 12}),
        letterSpace: 1,

        // TODO: asset("bg.png")
        backgroundPixmap: "/home/wooosh/bg.png",
        borderColor: "#323232",

        foreground: "#cbf3f3"
      },
    },
  }
]
