<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trabalhobd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
if(!empty($_POST['id_escola'])){
    $sql = "SELECT * FROM telefone WHERE escola_id= ".$_POST['id_escola'];
    $result = $conn->query($sql);
}

//echo json_encode($result->fetch_assoc());

echo "xupix";