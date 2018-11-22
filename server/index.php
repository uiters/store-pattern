<?php
require_once 'Model/Login.php';
$header = isset($_SERVER['HTTP_HEADER']) ? $_SERVER['HTTP_HEADER'] : null;
$body = isset($_POST['header']) ? $_POST['header'] : null;
//echo "$header<p>$body";
$login = new Login();
$login->builder($header, $body);
?>