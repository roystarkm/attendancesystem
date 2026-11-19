<?php
require_once 'includes/config.php';

if (isLoggedIn()) {
    logActivity("User logged out");
    session_unset();
    session_destroy();
}

redirect('index.php');
?>