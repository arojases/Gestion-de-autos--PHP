<?php 

function phpmotorsConnect()
{
/* Proxy connection to the phpmotors database */

    $server = getenv('DB_HOST') ?: getenv('MYSQLHOST') ?: 'localhost';
    $port = getenv('DB_PORT') ?: getenv('MYSQLPORT') ?: '3306';
    $dbname = getenv('DB_NAME') ?: getenv('MYSQLDATABASE') ?: 'phpmotors';
    $username = getenv('DB_USER') ?: getenv('MYSQLUSER') ?: 'iClient';
    $password = getenv('DB_PASSWORD') ?: getenv('MYSQLPASSWORD') ?: 'jSOIy]RCf1vmI)bQ';
    $dsn = "mysql:host=$server;port=$port;dbname=$dbname;charset=utf8mb4";
    $options = array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION);

    try {
        //code...
        $link = new PDO($dsn, $username, $password, $options);
        return $link;
        //return $link;
        /* if (is_object($link)) {
            echo 'It Worked!';
        } */
        

    } catch (PDOException $e) {

        header('Location: /phpmotors/view/500.php');
        exit;
        /* echo "It didn't work, error: ".$e->getMessage(); */
    }
}

//phpmotorsConnect();
