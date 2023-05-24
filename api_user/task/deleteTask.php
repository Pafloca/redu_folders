<?php
include "../connection.php";

$taskId = $_POST["task_id"];

$sqlQuery2 = "DELETE FROM `own_tasks` WHERE id = $taskId";

$resultOfQuery2 = $connectNow->query($sqlQuery2);