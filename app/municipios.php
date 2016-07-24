<?php

$filename = "municipios.csv";

$delimitador = ",";

$file = fopen("../planilhas/".$filename, "r");

$municipios = array();

while (!feof($file)) {
	$linha = fgets($file);
	array_push($municipios, $linha);
}

fclose($file);

$teste = array_unique($municipios);

$file2 = fopen("municipios-seeder.sql", "a");

foreach ($teste as $municipio) {
	fwrite($file2, $municipio);
}

fclose($file2);
