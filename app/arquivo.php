<?php
session_start();

try {
    $user = 'root';
    $pass = '';
    $dbh = new PDO('mysql:host=localhost;dbname=ivento3sudej2016;charset=utf8', $user, $pass);
    
    // $query = 'UPDATE criterios set total_vagas=10 WHERE id=4';
    $query = $_GET["consulta"];

    $consulta = $dbh->query($query);

    if ($consulta) {
        if(strtolower(substr($query, 0, 6)) == 'select') {
            $resultado = $consulta->fetchAll();
            echo json_encode($resultado);
        }
    } else {
        echo "consulta sem seleção";
    }

    $dbh = null; // fecha a conexão
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
