{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
     system = "aarch64-linux";
     modules = [
       ({pkgs, ...}: {
         # Only allow this to boot as a container
         boot.isContainer = true;
         networking.hostName = "test-server";

         # Allow nginx through the firewall
         networking.firewall.allowedTCPPorts = [ 80 ];

         services.static-web-server = {
           enable = true;
           listen = "[::]:80";
           root = ./.;
         };
        })
      ];
    };
  };
}
