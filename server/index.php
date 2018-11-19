<?php
require_once 'Model/Login.php';
$header = isset($_SERVER['HTTP_HEADER']) ? $_SERVER['HTTP_HEADER'] : null;
$login = new Login();
$login->builder($header);
?>