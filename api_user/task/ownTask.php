<?php
include "../connection.php";

$userId = $_POST["user_id"];

$sqlQuery2 = "SELECT * FROM own_tasks WHERE user_id = '$userId'";

$resultOfQuery2 = $connectNow->query($sqlQuery2);

$tasks = [];

if($resultOfQuery2->num_rows > 0) {
    while($rowFound = $resultOfQuery2->fetch_assoc()) {
        $tasks[] = $rowFound;
    }
    echo json_encode(
        array(
            'success' => true,
            'tasksData' => $tasks,
        )
    );
} else {
    echo json_encode(
        array(
            'success' => false
        )
    );
}