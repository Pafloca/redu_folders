<?php

$id = $_POST['id'];

$image = $id.'-task.jpg';
$imagePath = '../../../../Users/Admin/Desktop/reduAplication/redu/public/taskImg/'.$image;
$tmp_name = $_FILES['image']['tmp_name'];
move_uploaded_file($tmp_name, $imagePath);