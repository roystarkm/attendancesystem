<?php
echo "BASE_DIR: " . dirname(__DIR__) . "<br>";
echo "Header path: " . dirname(__DIR__) . '/includes/header.php' . "<br>";
echo "File exists: " . (file_exists(dirname(__DIR__) . '/includes/header.php') ? 'YES' : 'NO');
?>