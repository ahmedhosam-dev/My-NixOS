{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # Hello, world!
  services.pipewire.extraConfig.pipewire."filter-chain.conf" = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Cancelling Source";
          "media.name" = "Noise Cancelling Source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "node.name" = "playback.rnnoise_sink";
            "media.class" = "Audio/Sink";
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
}
