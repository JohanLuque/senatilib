<?php
require_once '../models/Subcategoria.php';

if (isset($_POST["operacion"])){
  $subcategoria = new Subcategoria();
  
  if ($_POST["operacion"] == "listarSubcategorias") {
    $datosObtenidos = $subcategoria->listarSubcategorias();
    echo json_encode($datosObtenidos);
  }
}