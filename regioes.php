<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "trabalhobd";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

//$sql = "SELECT e.id,e.rede, e.nome as nome,e.localizacao,s.regiao as regiao FROM escola AS e INNER JOIN Municipio AS m ON e.municipio_id = m.id INNER JOIN estado as s on s.uf=m.estado_id ORDER BY s.regiao";
$sql = "SELECT e.regiao from estado as e GROUP BY e.regiao ";
$result = $conn->query($sql);
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
            <li><a href="estados.php">Estados</a></li>
            <li class="active"><a href="regioes.php">Regiões</a></li>
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
        <table class="table table-hover" id="escolas">
        <thead>
          <tr>
            <th>Regiao</th>
          </tr>
        </thead>
        <tbody>
        <?php
          if ($result->num_rows > 0) {
            while($row = $result->fetch_array()) {
              echo "<tr>";
                echo"<td><a href='#'  data-toggle=\"modal\" data-target=\"#myModal\" data-regiao='".$row['regiao']."'>".$row['regiao']."</td>";
              echo "</tr>";
            }
        } else {
          echo "0 results";
        }?>
        </tbody>
      </table></div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog modal-lg" role="document">
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
        var recipient = button.data('regiao') // Extract info from data-* attributes


        $.ajax({
          type: 'post',
          dataType: 'html',
          url: 'app/ajax_regiao.php',
          data:{'regiao':button.data('regiao')},
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
