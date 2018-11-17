<?php
$header = isset($_SERVER['HTTP_HEADER']) ? $_SERVER['HTTP_HEADER'] : null;
$body = isset($_POST['noneQuery']) ? $_POST['noneQuery'] : null;
$login = new Login();
$login->builder($header, $body);
?>