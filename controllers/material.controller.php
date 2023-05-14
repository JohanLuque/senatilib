<?php
require_once '../models/Material.php';

if(isset($_POST['operacion'])){
  $material = new Material();
  if($_POST['operacion'] == 'registrarMaterial'){
    $datosGuardados =[
      "idsubcategoria"        => $_POST['idsubcategoria'],
      "ideditorial"           => $_POST['ideditorial'],
      "titulo"                => $_POST['titulo'],
      "sinopsis"              => $_POST['sinopsis'],
      "versionmat"            => $_POST['versionmat'],
      "autor"                 => $_POST['autor'],
      "cantpaginas"           => $_POST['cantpaginas'],
      "apublicacion"          => $_POST['apublicacion'],
      "caratula"              => $_POST['caratula'],
      "materialpdf"           => $_POST['materialpdf']
    ];
      $respuesta = $material->registrarMaterial($datosGuardados);
      echo json_encode($respuesta);
  }

  if ($_POST['operacion'] == 'listarMateriales') {
    $datos = $material->listarMateriales();
    if ($datos) {
      echo json_encode($datos);
    }
  }
}