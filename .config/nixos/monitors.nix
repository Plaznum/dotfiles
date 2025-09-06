{ config, pkgs, ... }:
{
  services.xserver.displayManager.gdm.enable = true;

  systemd.services.copyGdmMonitorsXml = {
    description = "Copy monitors.xml to GDM config";
    after = [ "network.target" "systemd-user-sessions.service" "display-manager.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo \"Running copyGdmMonitorsXml service\" && mkdir -p g/gdm/.config && echo \"Created /run/gdm/.config directory\" && [ \"/home/pandy/.config/monitors.xml\" -ef \"/nix/store/nicbhvrbrr7k3256izg4byixkjmj6513-gdm_monitors.xml\" ] || cp /home/pandy/.config/monitors.xml /nix/store/nicbhvrbrr7k3256izg4byixkjmj6513-gdm_monitors.xml && echo \"Copied monitors.xml to /nix/store/nicbhvrbrr7k3256izg4byixkjmj6513-gdm_monitors.xml\" && chown gdm:gdm /nix/store/nicbhvrbrr7k3256izg4byixkjmj6513-gdm_monitors.xml && echo \"Changed ownership of monitors.xml to gdm\"'";
      Type = "oneshot";
    };

    wantedBy = [ "multi-user.target" ];
  };

}
