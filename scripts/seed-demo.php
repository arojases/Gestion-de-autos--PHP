<?php

$host = getenv('DB_HOST') ?: getenv('MYSQLHOST') ?: 'localhost';
$port = getenv('DB_PORT') ?: getenv('MYSQLPORT') ?: '3306';
$database = getenv('DB_NAME') ?: getenv('MYSQLDATABASE') ?: 'phpmotors';
$user = getenv('DB_USER') ?: getenv('MYSQLUSER') ?: 'iClient';
$password = getenv('DB_PASSWORD') ?: getenv('MYSQLPASSWORD') ?: 'jSOIy]RCf1vmI)bQ';

$dsn = "mysql:host=$host;port=$port;dbname=$database;charset=utf8mb4";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

$attempts = 30;
while ($attempts > 0) {
    try {
        $db = new PDO($dsn, $user, $password, $options);
        break;
    } catch (PDOException $e) {
        $attempts--;
        if ($attempts === 0) {
            fwrite(STDERR, "Database connection failed: {$e->getMessage()}\n");
            exit(1);
        }
        sleep(2);
    }
}

$tables = $db->query("SHOW TABLES LIKE 'inventory'")->fetchAll();
if (!$tables) {
    importSql($db, __DIR__ . '/../sql/phpmotors.sql');
}

importSql($db, __DIR__ . '/../sql/demo-data.sql');
echo "Demo database is ready.\n";

function importSql(PDO $db, string $path): void
{
    $sql = file_get_contents($path);
    if ($sql === false) {
        throw new RuntimeException("Could not read SQL file: $path");
    }

    $db->exec($sql);
}

