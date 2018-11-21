<?php
require_once 'Model/Verifier.php';
$token = isset($_SERVER['HTTP_TOKEN']) ? $_SERVER['HTTP_TOKEN'] : null;

$query = isset($_POST['query']) ? $_POST['query'] : null;
$noneQuery = isset($_POST['noneQuery']) ? $_POST['noneQuery'] : null;

$verifier = new Verifier($token, $query ,$noneQuery);
$verifier->builder();
?>