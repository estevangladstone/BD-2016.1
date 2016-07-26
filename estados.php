<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trabalhobd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT e.rede, e.nome,s.nome as estado FROM escola AS e INNER JOIN municipio AS m ON e.municipio_id = m.id INNER JOIN estado as s ON s.uf = m.estado_id";
$result = $conn->query($sql);

$sql2 = "SELECT uf,nome, regiao FROM estado AS e ORDER BY nome ASC Limit 9";
$estadosAsc = $conn->query($sql2);

$sql3 = "(SELECT  * FROM estado ORDER BY nome DESC Limit 9) ORDER by nome ASC";
$estadosDesc = $conn->query($sql3);

$sql4 = "SELECT * FROM estado  WHere uf > 'GO' and uf< 'RJ' ORDER BY nome ASC";
$estadosMid = $conn->query($sql4);
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Justified Nav Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="datatables.css"/>

    <script type="text/javascript" src="jQuery-2.2.3/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="datatables.js"></script>

    <!-- Custom styles for this template -->
    <link href="justified-nav.css" rel="stylesheet">
  </head>
  <body>
    <div class="container">
      <div class="masthead">
        <h3 class="text-muted">Trabalho de Banco de Dados</h3>
        <nav>
          <ul class="nav nav-justified">
            <li><a href="escolas.php">Escolas</a></li>
            <li class="active"><a href="estados.php">Estados</a></li>
            <li><a href="regioes.php">Regiões</a></li>
          </ul>
        </nav>
      </div>

      <div class="row consulta">
        <form id="form" action="app/arquivo.php" method="get">
          <div class="input-group">
            <input type="text" id="consulta" class="form-control" name="consulta" placeholder="Digite sua consulta...">
				<span class="input-group-btn">
					<button class="btn btn-default" type="submit">
                      <span class="glyphicon glyphicon-search"></span>
                    </button>
				</span>
          </div>
        </form>
      </div>

      <div class="row">
        <div class="col-md-4">
          <table class="table table-hover">
            <thead>
            <tr>
              <th>UF</th>
              <th>Nome</th>
              <th>Região</th>
            </tr>
            </thead>
            <tbody>
            <?php
            if ($estadosAsc->num_rows > 0) {
              while($row = $estadosAsc->fetch_array()) {
                echo "<tr>";
                echo"<td>".$row['uf']."</td>";
                echo"<td><a href='#'  data-toggle=\"modal\" data-target=\"#myModal\" data-nome='".$row['nome']."' data-uf='".$row['uf']."'> ".$row['nome']."</a></td>";
                echo"<td>".$row['regiao']."</td>";
                echo "</tr>";
              }
            } else {
              echo "0 results";
            }?>
            </tbody>
          </table>
        </div>
        <div class="col-md-4">
          <table class="table table-hover">
            <thead>
            <tr>
              <th>UF</th>
              <th>Nome</th>
              <th>Região</th>
            </tr>
            </thead>
            <tbody>
            <?php
            if ($estadosMid->num_rows > 0) {
              while($row = $estadosMid->fetch_array()) {
                echo "<tr>";
                echo"<td>".$row['uf']."</td>";
                echo"<td><a href='#'  data-toggle=\"modal\" data-target=\"#myModal\" data-nome='".$row['nome']."' data-uf='".$row['uf']."'> ".$row['nome']."</a></td>";

                echo"<td>".$row['regiao']."</td>";
                echo "</tr>";
              }
            } else {
              echo "0 results";
            }?>
            </tbody>
          </table>
        </div>
        <div class="col-md-4">
          <table class="table table-hover">
            <thead>
            <tr>
              <th>UF</th>
              <th>Nome</th>
              <th>Região</th>
            </tr>
            </thead>
            <tbody>
            <?php
            if ($estadosDesc->num_rows > 0) {
              while($row = $estadosDesc->fetch_array()) {
                echo "<tr>";
                echo"<td>".$row['uf']."</td>";
                echo"<td><a href='#'  data-toggle=\"modal\" data-target=\"#myModal\" data-nome='".$row['nome']."' data-uf='".$row['uf']."'> ".$row['nome']."</a></td>";
                echo"<td>".$row['regiao']."</td>";
                echo "</tr>";
              }
            } else {
              echo "0 results";
            }?>
            </tbody>
          </table>
        </div>
      </div>

      <div class="row">
        <table class="table table-hover" id="escolas">
          <thead>
          <tr>
            <th>Rede</th>
            <th>Nome</th>
            <th>Estado</th>
          </tr>
          </thead>
          <tbody>
          <?php
          if ($result->num_rows > 0) {
            while($row = $result->fetch_array()) {
              echo "<tr>";
              echo"<td>".$row['rede']."</td>";
              echo"<td>".$row['nome']."</td>";
              echo"<td>".$row['estado']."</td>";
              echo "</tr>";
            }
          } else {
            echo "0 results";
          }?>
          </tbody>
        </table>
      </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
          </div>
          <div class="modal-body">
            <div id="teste"></div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <script>
      $(document).ready( function () {
        $('#escolas').DataTable({
          "language": {
            "sEmptyTable": "Nenhum registro encontrado",
            "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
            "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
            "sInfoFiltered": "(Filtrados de _MAX_ registros)",
            "sInfoPostFix": "",
            "sInfoThousands": ".",
            "sLengthMenu": "_MENU_ resultados por página",
            "sLoadingRecords": "Carregando...",
            "sProcessing": "Processando...",
            "sZeroRecords": "Nenhum registro encontrado",
            "sSearch": "",
            "oPaginate": {
              "sNext": "Próximo",
              "sPrevious": "Anterior",
              "sFirst": "Primeiro",
              "sLast": "Último"
            },
            "oAria": {
              "sSortAscending": ": Ordenar colunas de forma ascendente",
              "sSortDescending": ": Ordenar colunas de forma descendente"
            }
          }
        });
      } );

      $('#myModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var recipient = button.data('nome') // Extract info from data-* attributes

        $.ajax({
          type: 'post',
          dataType: 'html',
          url: 'app/ajax_estado.php',
          data:{'uf':button.data('uf')},
          success:function(dataset) {
//            $('#codigo').text("("+data.codigo+")")
//            $('#numero').text(data.numero)
            $('#teste').html(dataset)
          }
        });

        var modal = $(this)
        modal.find('.modal-title').text(recipient)

      })
    </script>
  </body>
</html>
