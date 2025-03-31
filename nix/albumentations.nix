{
  lib,
  python3,
  fetchPypi,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "albumentations";
  version = "1.4.24";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-zIh0ywq8zJEXrvrL44XDVKyCT6FC9GpsCJbWXOxfim0=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    scipy
    pydantic
    opencv-python-headless
    torch
    albucore
  ];

  pythonImportsCheck = [ "albumentations" ];

  meta = with lib; {
    description = "Albumentations is a Python library for image augmentation. Image augmentation is used in deep learning and computer vision tasks to increase the quality of trained models. The purpose of image augmentation is to create new training samples from the existing data.";
    homepage = "https://pypi.org/project/albumentations/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "albumentations";
  };
}
