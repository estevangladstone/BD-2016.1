<?php

$files = [
	"rendimentoescolaCO",
	"rendimentoescolaN",
	"rendimentoescolaNaBM",
	"rendimentoescolaNeBM",
	"rendimentoescolaS",
	"rendimentoescolaSd"
];

$delimitador = ";";

foreach ($files as $filename) {

	if (!file_exists($filename.".csv")) { 
	    die('File does not exist');
	}

	$csv = fopen($filename.".csv", "r");
	var_dump($csv);
	die();

	$congressistas = array();

	while (($linha = fgetcsv($csv, 0, $delimitador)) !== false) {
	    array_push($congressistas, ['rede' => $linha[6], 'localizacao' => $linha[5], 'nome' => $linha[8], 'municipio' => $linha[4]]);
	}

	fclose($csv);

	$file2 = fopen("escolas-seeder.sql", "a");

	foreach ($teste as $municipio) {
		$str = "(\"".$escola[0]."\",\"".$escola[1]."\",\"".$escola[2]."\",\"".$escola[3]."\"),";
		fwrite($file2, $str);
	}

	fclose($file2);
}
