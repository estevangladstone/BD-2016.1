<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trabalhobd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
if(!empty($_POST['uf'])){
    $sql = "SELECT count(e.id) as n_escolas From escola as e INNER  JOIN  municipio as m on m.id = e.municipio_id INNER JOIN estado as s on s.uf = m.estado_id WHERE s.uf='".$_POST['uf']."'";
    $result1 = $conn->query($sql);

    $sql2 = "SELECT avg(t.valor) as media,t.tipo as tipo, m.estado_id as uf FROM escola as e INNER JOIN municipio as m on m.id=e.municipio_id INNER JOIN taxa as t on t.escola_id = e.id WHERE m.estado_id='".$_POST['uf']."' GROUP by t.tipo";
    $result2 = $conn->query($sql2);
}
$html ="Numero de avaliadas neste estado:<span>(".$result1->fetch_assoc()['n_escolas'].") </span><br>";

if ($result2->num_rows > 0) {
    while($row = $result2->fetch_array()) {
        $html .= "<b>".$row['tipo'].":</b> ";
        $html .="<span>".$row['media']."</span><br>";
    }
} else {
    echo "0 results";
}

echo ($html);