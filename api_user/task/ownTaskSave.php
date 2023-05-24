<?php
include "../connection.php";

$name = $_POST["title"];
$description = $_POST["description"];
$idUser = $_POST["user_id"];
$idGroup = $_POST["group_id"];


$sqlQuery = "INSERT INTO own_tasks SET title = '$name', description = '$description', user_id = $idUser, group_id = $idGroup";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery) {

    echo json_encode(
        array(
            'success' => true
        )
    );

} else {
    echo json_encode(
        array(
            'success' => false
        )
    );
}