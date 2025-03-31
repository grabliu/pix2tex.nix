{
  lib,
  python3,
  fetchPypi,
  callPackage,
}:
let
  pyobjc-framework-Quartz = callPackage ./pfq.nix { };
  pyobjc-framework-CoreText = callPackage ./pfc.nix { inherit pyobjc-framework-Quartz; };
  pyobjc-framework-ApplicationServices = callPackage ./pfa.nix { 
    inherit pyobjc-framework-Quartz pyobjc-framework-CoreText;
  };
in
python3.pkgs.buildPythonPackage rec {
  pname = "pynput";
  version = "1.7.7";
  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-r8Q/ZRaEyYgY3gSKvHat+fLT15cIPLB8H4K+dkotRMs=";
    format = "wheel";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = [
    python3.pkgs.six
    pyobjc-framework-Quartz
    pyobjc-framework-ApplicationServices
  ];

  pythonImportsCheck = [ "pynput" ];

  meta = with lib; {
    description = "The pynput mapping and its loss, a family of sparse alternatives to softmax";
    homepage = "https://pypi.org/project/pynput/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "pynput";
  };
}
