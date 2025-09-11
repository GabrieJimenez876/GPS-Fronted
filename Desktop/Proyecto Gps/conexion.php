<?php
$servidor = "localhost"; // o 127.0.0.1
$usuario = "root";       // por defecto en XAMPP
$password = "";          // por defecto está vacío
$basedatos = "sistema_transporte"; // el nombre de tu BD

$conn = new mysqli($servidor, $usuario, $password, $basedatos);

if ($conn->connect_error) {
    die("Error en la conexión: " . $conn->connect_error);
}
?>
