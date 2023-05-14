<?php
require_once 'Conexion.php';

class Categoria extends Conexion{
  private $conexion;

  //Constructor
  public function __CONSTRUCT(){
    $this->conexion = parent::getConexion();
  }

  public function listarCategorias(){
    try{
      $consulta = $this->conexion->prepare("CALL spu_listar_categoria()");
      $consulta->execute();
      return $consulta->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(Exception $e){
      die($e->getMessage());
    }
  }


  
}