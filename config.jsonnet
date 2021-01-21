local modules = import 'modules.libsonnet';

  modules.xresources {
    enabled: true,
    config: {
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
