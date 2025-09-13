<?php
include("conexion.php");

// Obtener datos del formulario
$usuario = $_POST['usuario'];
$clave   = $_POST['clave'];

// Consultar si existe el usuario
$sql = "SELECT * FROM usuarios WHERE usuario='$usuario' AND clave='$clave'";
$resultado = $conn->query($sql);

if ($resultado->num_rows > 0) {
    // Usuario válido
    session_start();
    $_SESSION['usuario'] = $usuario;
    header("Location: panel.php"); // redirige al panel
} else {
    echo "Usuario o contraseña incorrectos";
}
?>
