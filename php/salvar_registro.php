<?php
    require_once("conn.php");
    
    $sql = "INSERT INTO user (email, desejos, facebook) VALUES (
        '".$_POST["email"]."',
        '".implode(",", $_POST["desejos"])."',
        '".$_POST["facebook"]."'
    )";
    $dbcon->query($sql);
    var_dump($_POST);