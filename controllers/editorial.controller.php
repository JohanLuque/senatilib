<?php
require_once '../models/Editorial.php';

if (isset($_POST["operacion"])){
  $editorial = new Editorial();
  
  if ($_POST["operacion"] == "listarEditoriales") {
    $datosObtenidos = $editorial->listarEditoriales();
    echo json_encode($datosObtenidos);
  }
}