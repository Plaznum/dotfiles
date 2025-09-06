{ config, pkgs, ... }:
{
	networking.hostName = "shisa";
	networking.extraHosts = ''
		192.168.1.94    lappy
		192.168.1.96    kageneko  kn  kagethecat
		192.168.1.97    dv1
		192.168.1.247   elitelappy
		192.168.1.215   wiiu
		192.168.1.216   3ds
		10.80.1.10      parse1
		10.80.1.18      devel1
		'';

}

