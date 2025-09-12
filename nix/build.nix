{ toolchain, makeRustPlatform, ... }:
(makeRustPlatform {
  cargo = toolchain;
  rustc = toolchain;
}).buildRustPackage
  {
    pname = "android";
    version = "0.0.1";
    src = ./..;
    cargoLock.lockFile = ../Cargo.lock;
  }
