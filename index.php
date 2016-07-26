<?php 
	require_once('app/arquivo.php');
 ?>
<html>
<head>
	<title>Taxas de Rendimento Escolar na Educação Básica</title>
	<meta charset="utf-8">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css"/>

 </head>
<body>
	<div class="container">
		<div class="masthead">
			<h3 class="text-muted">Trabalho de Banco de Dados</h3>
			<nav>
				<ul class="nav nav-justified">
					<li><a href="escolas.php">Escolas</a></li>
					<li><a href="estados.php">Estados</a></li>
					<li><a href="regioes.php">Regiões</a></li>
					<li class="active"><a href="index.php">Consulta</a></li>
				</ul>
			</nav>
		</div>

		<form id="form" action="index.php" method="get">
			<div class="input-group">
				<input type="text" id="consulta" class="form-control" name="consulta" placeholder="Digite sua consulta...">
				<span class="input-group-btn">
					<button id="teste" class="btn btn-default" type="submit">
						<span class="glyphicon glyphicon-search" style="font-size: 20px"></span>
					</button>
				</span>
			</div>
		</form>
		<table class="table" id="resultados">
			<?php if(!empty($_SESSION['colunas']) && !empty($_SESSION['resultados'])) { ?>
				<!-- Cabeçalho -->
				<thead>
					<?php foreach ($_SESSION['colunas'] as $column) { ?>
						<th><?php echo $column ?></th>
					<?php } unset($_SESSION['colunas']); //endforeach ?>
				</thead>
				<!-- Linhas -->
				<tbody>
					<?php foreach ($_SESSION['resultados'] as $linha) { ?>
						<tr>
							<?php foreach ($linha as $celula) { ?>
								<td><?php echo $celula ?></td>
							<?php } //endforeach ?>
						</tr>
					<?php } unset($_SESSION['resultados']); //endforeach ?>
				</tbody>
			<?php } else { ?>			
				<tr>Nenhum resultado encontrado</tr>
			<?php } //endif ?>
		</table>
	</div>

	<script src="https://code.jquery.com/jquery-2.2.4.js" integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI=" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		    $('#resultados').DataTable();
		} );
	</script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</body>
</html>
