<?php
$servername = "";
$username = "";
$password = "";
$dbname = "";

if(isset($_POST['executeNoneQuery']) && !empty($_POST['executeNoneQuery']))
    executeNoneQuery($_POST['executeNoneQuery']);
else
    if(isset($_POST['executeQuery']) && !empty($_POST['executeQuery']))
        executeQuery($_POST['executeQuery']);
else echo 0;

function executeNoneQuery($query) {
    global $servername, $username, $password, $dbname;
    $connect = new mysqli($servername, $username, $password, $dbname);
    if($connect->connect_error){
        echo 0;
        return;
    }
    else
    {
        $data = $connect->query($query);
        $connect->close();
        echo $data ? 1 : 0;
    }
}

function executeQuery($qeury) { // null is false
    global $servername, $username, $password, $dbname;
    $connect = new mysqli($servername, $username, $password, $dbname);
    mysqli_set_charset($connect, 'UTF8');
    if($connect->connect_error) {
        echo 0;
        return;
    };

    $data = $connect->query($qeury);

    $rows = array();
    while($array = $data->fetch_assoc()) {
        $rows[] = $array;
    }
    $data->close();
    $connect->close();
    echo  json_encode($rows);
}
?>