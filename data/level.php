<?php
$level_code = "return {\n\tdata = {\n";
$row = 1;
if (($handle = fopen("level.csv", "r")) !== FALSE) {
	while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
		$num = count($data);
		$row++;
		$level_code .= "\t\t{ ";
		for ($c=0; $c < $num; $c++) {
			$level_code .= "".($data[$c] + 0).", ";
		}
		$level_code .= "},\n";
	}
	fclose($handle);
}
$level_code .= "\n\t}\n}\n";
echo $level_code;
