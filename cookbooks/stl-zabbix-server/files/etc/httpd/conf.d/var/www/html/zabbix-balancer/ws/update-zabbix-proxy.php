<?php

/* ideia Ambrosia de Araujo ambrosia@gmail.com - desenvolvimento Ambrosia Ambrosiano e Emilio Emiliano emilio@gmail.com */

define('MYSQL_HOST', 'dbmysql.tabajara.intranet'); 
define('MYSQL_PORT', 3306);
define('MYSQL_USER', 'zabbixuser');
define('MYSQL_PASS', 'Mudar@123');
define('MYSQL_DB', 'zabbixdb');

if (!empty($_POST['proxy_hostid']) && !empty($_POST['host'])) {
    $connStr = 'mysql:host=' . MYSQL_HOST . ';port=' . MYSQL_PORT . ';dbname=' . MYSQL_DB;

    try {
        $conn = new PDO($connStr, MYSQL_USER, MYSQL_PASS);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $update = "UPDATE hosts
                      SET proxy_hostid = '{$_POST['proxy_hostid']}'
                    WHERE host = '{$_POST['host']}'";

        $conn->exec($update);
    } catch (Exception $e) {
        http_response_code(500);
        echo "ERRO: {$e->getMessage()}\n";
    }
}
