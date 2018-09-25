{ mkDerivation, base, bytestring, network-simple-wss, pipes, stdenv
}:
mkDerivation {
  pname = "pipes-network-wss";
  version = "0.1";
  src = ./.;
  libraryHaskellDepends = [
    base bytestring network-simple-wss pipes
  ];
  homepage = "https://github.com/k0001/pipes-network-wss";
  description = "Secure WebSockets support for pipes";
  license = stdenv.lib.licenses.bsd3;
}
