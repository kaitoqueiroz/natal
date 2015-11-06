<?php
    function dbConnect()
    {
        global $dbcon;

        $dbInfo['server'] = "localhost";
        $dbInfo['database'] = "gazin";
        $dbInfo['username'] = "gazin_user";
        $dbInfo['password'] = "BY4a8bBqKw7Zyd5H";

        $con = "mysql:host=" . $dbInfo['server'] . "; dbname=" . $dbInfo['database'].";charset=utf8";
        $dbcon = new PDO($con, $dbInfo['username'], $dbInfo['password']);
        $dbcon->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $error = $dbcon->errorInfo();

        return $dbcon;
    }

    $conn = dbConnect();