<?php
session_start();

if(!empty($_GET['consulta'])){
    try {
        $user = 'root';
        $pass = '';
        $dbh = new PDO('mysql:host=localhost;dbname=trabalhobd;charset=utf8', $user, $pass);
        
        // $query = 'UPDATE criterios set total_vagas=10 WHERE id=4';
        // $query = "select estados.nome as nomeEstado, municipios.nome as nomeMunicipio, estados.uf from municipios join estados on municipios.estado_id=estados.uf limit 10";
        $query = $_GET["consulta"];

        $consulta = $dbh->query($query);

        if ($consulta) {
            if(strtolower(substr($query, 0, 6)) == 'select') {
                $resultado = $consulta->fetchAll(PDO::FETCH_ASSOC);
                $colunas = array_keys($resultado[0]);

                $_SESSION['colunas'] = $colunas;
                $_SESSION['resultados'] = $resultado;
            }
        }

        $dbh = null; // fecha a conexão
    } catch (PDOException $e) {
        print "Error!: " . $e->getMessage() . "<br/>";
        die();
    }
}
?>
