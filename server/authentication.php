<?php
require_once 'Model/Verifier.php';
$token = $_SERVER['HTTP_TOKEN'] == null ? null : $_SERVER['HTTP_TOKEN'];

$query = $_POST['query'] == null ? null : $_POST['query'];
$noneQuery = $_POST['noneQuery'] == null ? null : $_POST['noneQuery'];

$verifier = new Verifier($token, $query ,$noneQuery );
$verifier->builder();
?>