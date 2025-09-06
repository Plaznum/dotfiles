#{ config, pkgs, ... }:
#{
#  systemd.timers."worksync" = {
#    wantedBy = [ "timers.target" ];
#    timerConfig = {
#      OnBootSec = "5m";
#      Unit = "worksync.service";
#    };
#  };
#
#  systemd.services."worksync" = {
#    script = ''
#      ${pkgs.rsync}/bin/rsync -trv /home/pandy/Documents/work/ 192.168.1.96:/home/pandy/work/
#      '';
#    serviceConfig = {
#      #ExecStart = "rsync -trv /home/pandy/Documents/work/ kageneko:/home/pandy/work/";
#      Type = "oneshot";
#      User = "pandy";
#    };
#  };
#}
