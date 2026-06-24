{ ... }: {
  containers.i2pd-container = {
    autoStart = false;
    config = { ... }: {
      networking.firewall.allowedTCPPorts = [
        7656
        7070
        4447
        4444
      ];

      services.i2pd = {
        enable = true;
        address = "127.0.0.1";
        proto = {
          http.enable = true;
          socksProxy.enable = true;
          httpProxy.enable = true;
          sam.enable = true;
        };
      };
    };
  };
}

