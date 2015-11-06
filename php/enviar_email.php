<?php
    require_once("conn.php");

    $sth = $conn->prepare("SELECT * FROM user WHERE email_enviado = 0");
    $sth->execute();


    $result = $sth->fetchAll();

    $to = 'kaitoqueiroz@gmail.com';

    $subject = 'Website Change Request';

    $headers = "From: " . strip_tags($_POST['req-email']) . "\r\n";
    //$headers .= "Reply-To: ". strip_tags($_POST['req-email']) . "\r\n";
    $headers .= "MIME-Version: 1.0\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

    $message = '<html><body>';
    $message .= '<h1>Hello, World!</h1>';
    $message .= '</body></html>';

    mail($to, $subject, $message, $headers);