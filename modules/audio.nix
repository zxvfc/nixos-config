{ pkgs, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."loopback" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Mix";
            "capture.props" = {
              "node.name" = "mix_sink";
              "media.class" = "Audio/Sink";
              "audio.position" = [
                "FL"
                "FR"
              ];
            };
            "playback.props" = {
              "node.name" = "mix_source";
              "media.class" = "Audio/Source";
              "node.passive" = true;
              "audio.position" = [
                "FL"
                "FR"
              ];
            };
          };
        }
      ];
    };

  };
  users.users.zxvfc.extraGroups = [ "audio" ];
  # Realtime privileges for the audio group
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "soft";
      value = "99999";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "hard";
      value = "99999";
    }
  ];

  environment = {
    pathsToLink = [
      "/lib/lv2"
      "/lib/vst3"
      "/lib/clap"
      "/lib/ladspa"
    ];
    sessionVariables = {
      LV2_PATH = "/run/current-system/sw/lib/lv2";
      VST3_PATH = "/run/current-system/sw/lib/vst3";
      CLAP_PATH = "/run/current-system/sw/lib/clap";
      LADSPA_PATH = "/run/current-system/sw/lib/ladspa";
    };
    systemPackages = with pkgs; [
      ardour
      qpwgraph
      guitarix-vst
    ];
  };

}
