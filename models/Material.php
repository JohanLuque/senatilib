<?php
require_once 'Conexion.php';

class Material extends Conexion{
  private $conexion;

  //Constructor
  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function listarMateriales() {
    try {
      $consulta = $this->conexion->prepare("CALL spu_materiales_listar()");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    } catch(Exception $e) {
      $respuesta["message"] = "No se ha podido completar el proceso. Código de error: " . $e->getCode();
    }
  }

  public function registrarMaterial($datos = []) {
    $respuesta = [
      "status"  => false,
      "message" => ""
    ];

    try {
      $consulta = $this->conexion->prepare("CALL spu_registrar_material(?,?,?,?,?,?,?,?,?,?)");
      $respuesta["status"] = $consulta->execute(
        array(
          $datos["idsubcategoria"],
          $datos["ideditorial"],
          $datos["titulo"],
          $datos["sinopsis"],
          $datos["versionmat"],
          $datos["autor"],
          $datos["cantpaginas"],
          $datos["apublicacion"],
          $datos["caratula"],
          $datos["materialpdf"]
        )
      );
    } catch(Exception $e) {
      $respuesta["message"] = "No se ha podido completar el proceso. Código de error: " . $e->getCode();
    }

    return $respuesta;
  }
}