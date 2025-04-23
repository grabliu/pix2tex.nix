{
  python3,
  darwin,
  fetchFromGitHub,
  lib,
  callPackage,
  pyobjc-framework-Quartz,
  pyobjc-framework-CoreText,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pyobjc-framework-ApplicationServices";
  version = "11.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ronaldoussoren";
    repo = "pyobjc";
    tag = "v${version}";
    hash = "sha256-RhB0Ht6vyDxYwDGS+A9HZL9ySIjWlhdB4S+gHxvQQBg=";
  };

  sourceRoot = "source/pyobjc-framework-ApplicationServices";

  build-system = [ python3.pkgs.setuptools ];

  buildInputs = [
    darwin.libffi
    darwin.DarwinTools
  ];

  nativeBuildInputs = [
    darwin.DarwinTools # sw_vers
  ];

  # See https://github.com/ronaldoussoren/pyobjc/pull/641. Unfortunately, we
  # cannot just pull that diff with fetchpatch due to https://discourse.nixos.org/t/how-to-apply-patches-with-sourceroot/59727.
  postPatch = ''
    substituteInPlace pyobjc_setup.py \
      --replace-fail "-buildversion" "-buildVersion" \
      --replace-fail "-productversion" "-productVersion"
  '';

  dependencies = [
    python3.pkgs.pyobjc-core
    python3.pkgs.pyobjc-framework-Cocoa
    pyobjc-framework-Quartz
    pyobjc-framework-CoreText
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-I${darwin.libffi.dev}/include"
    "-Wno-error=unused-command-line-argument"
  ];

  pythonImportsCheck = [ "ApplicationServices" ];

  meta = with lib; {
    description = "PyObjC wrappers for the ApplicationServices frameworks on macOS";
    homepage = "https://github.com/ronaldoussoren/pyobjc";
    license = licenses.mit;
    platforms = platforms.darwin;
    maintainers = with maintainers; [ samuela ];
  };
}