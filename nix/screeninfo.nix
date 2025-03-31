{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "screeninfo";
  version = "0.8.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-mYMHa8x+NEAqGp5NfavzcpQR/Sq7PztL5+unNRnNLtE=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    poetry-core
    cython
    pyobjc-framework-Cocoa
  ];

  pythonImportsCheck = [ "screeninfo" ];

  meta = with lib; {
    description = "The entmax mapping and its loss, a family of sparse alternatives to softmax";
    homepage = "https://pypi.org/project/screeninfo/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "screeninfo";
  };
}
