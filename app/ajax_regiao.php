<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trabalhobd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
if(!empty($_POST['regiao'])){
    $sql = "SELECT DISTINCT e.nome as nome,e.rede as rede,e.localizacao as localizacao,m.nome as municipio  FROM escola as e INNER JOIN municipio as m on m.id=e.municipio_id INNER JOIN taxa as t on t.escola_id = e.id INNER JOIN estado as s on s.uf=m.estado_id WHERE s.regiao ='".$_POST['regiao']."'";
    $result = $conn->query($sql);

}
$html ='<div class="row"><table class="table table-hover" id="escolas"><thead><tr><th>Rede</th><th>Nome</th><th>Localização</th><th>Municipio</th></tr></thead><tbody>';
if ($result->num_rows > 0) {
    while($row = $result->fetch_array()) {
        $html .= "<tr>";
        $html .="<td>".$row['rede']."</td>";
        $html .="<td>".$row['nome']."</a></td>";
        $html .="<td>".$row['localizacao']."</td>";
        $html .="<td>".$row['municipio']."</td>";
        $html .= "</tr>";
    }
} else {
    $html .= "0 results";
}
$html .= "</tbody></table></div>";

echo ($html);

