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
    $sql = "SELECT * FROM Telefone WHERE escola_id= ".$_POST['id_escola'];
    $result1 = $conn->query($sql);
    $fet = $result1->fetch_assoc();

    $taxas = "SELECT sum(valor) as soma, tipo FROM Taxa WHERE escola_id=".$_POST['id_escola']." GROUP BY tipo";
    $result2 = $conn->query($taxas);
}
$html ="Telefone de Contato:<span>(".$fet['codigo'].") ".$fet['numero']."</span>";
$html .='<div class="row"><table class="table table-hover" id="escolas"><thead><tr><th>Soma das Taxas</th><th>Tipo</th></tr></thead><tbody>';
          if ($result2->num_rows > 0) {
              while($row = $result2->fetch_array()) {
                  $html .= "<tr>";
                  $html .="<td>".$row['soma']."</td>";
                  $html .="<td>".$row['tipo']."</td>";
                  $html .= "</tr>";
              }
          } else {
              echo "0 results";
          }
$html .= "</tbody></table></div>";

echo ($html);

