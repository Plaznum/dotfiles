# Config file for my login screen fixes/shenanigans!

{ config, pkgs, ... }:

let

  monitorsXmlContent = builtins.readFile /home/pandy/.config/monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in

{

systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];
nixpkgs = {
    overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope (selfg: superg: {
          gnome-shell = super.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or []) ++ [
              (
                # bg = pkgs.fetchurl {
                #   url = "https://orig00.deviantart.net/0054/f/2015/129/b/9/reflection_by_yuumei-d8sqdu2.jpg";
                #   sha256 = "0f0vlmdj5wcsn20qg79ir5cmpmz5pysypw6a711dbaz2r9x1c79l";
                # };
              pkgs.writeText "bg.patch" ''
                --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
                 /* Login Dialog */
                 .login-dialog {
                   background-color: $_gdm_bg;
                +  background-image: url('file:///etc/nixos/lockscreen.jpg');
                 }
              '')
            ];
          });
        });
      })
    ];
  };
# login screen monitor fix
#  systemd.tmpfiles.rules = [
#    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
#      <!-- this should all be copied from your ~/.config/monitors.xml -->
#<monitors version="2">
#  <configuration>
#    <logicalmonitor>
#      <x>0</x>
#      <y>0</y>
#      <scale>1</scale>
#      <transform>
#        <rotation>right</rotation>
#        <flipped>no</flipped>
#      </transform>
#      <monitor>
#        <monitorspec>
#          <connector>DP-3</connector>
#          <vendor>VTK</vendor>
#          <product>GFV24CB</product>
#          <serial>0x00000000</serial>
#        </monitorspec>
#        <mode>
#          <width>1920</width>
#          <height>1080</height>
#          <rate>60.000</rate>
#        </mode>
#      </monitor>
#    </logicalmonitor>
#    <logicalmonitor>
#      <x>1080</x>
#      <y>1020</y>
#      <scale>1</scale>
#      <primary>yes</primary>
#      <monitor>
#        <monitorspec>
#          <connector>HDMI-1</connector>
#          <vendor>GSM</vendor>
#          <product>LG FULL HD</product>
#          <serial>0x01010101</serial>
#        </monitorspec>
#        <mode>
#          <width>1920</width>
#          <height>1080</height>
#          <rate>60.000</rate>
#        </mode>
#      </monitor>
#    </logicalmonitor>
#    <logicalmonitor>
#      <x>3000</x>
#      <y>759</y>
#      <scale>1</scale>
#      <monitor>
#        <monitorspec>
#          <connector>DP-1</connector>
#          <vendor>BNQ</vendor>
#          <product>ZOWIE XL LCD</product>
#          <serial>X5L01585SL0</serial>
#        </monitorspec>
#        <mode>
#          <width>1920</width>
#          <height>1080</height>
#          <rate>144.001</rate>
#        </mode>
#      </monitor>
#    </logicalmonitor>
#  </configuration>
#</monitors>
#    ''}"
#  ];



}
