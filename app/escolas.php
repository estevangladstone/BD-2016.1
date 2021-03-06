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

	$escolas = array();

	while (($linha = fgetcsv($csv, 0, $delimitador)) !== false) {
	    array_push($escolas, [$linha[6], $linha[5], $linha[8], $linha[4]]);
	}

	fclose($csv);

	$file2 = fopen("escolas-seeder.sql", "a");

	foreach ($escolas as $escola) {
		$str = "(\"".$escola[0]."\",\"".$escola[1]."\",\"".$escola[2]."\",\"".$escola[3]."\"),";
		fwrite($file2, $str);
	}

	fclose($file2);
}
