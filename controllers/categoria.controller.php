<?php
require_once '../models/Categoria.php';

if (isset($_POST["operacion"])){
  $categoria = new Categoria();
  
  if ($_POST["operacion"] == "listarCategorias") {
    $datosObtenidos = $categoria->listarCategorias();
    echo json_encode($datosObtenidos);
  }
}