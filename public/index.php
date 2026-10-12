<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/bootstrap.php';
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars($appConfig['app_name'], ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
    <main>
        <h1><?= htmlspecialchars($appConfig['app_name'], ENT_QUOTES, 'UTF-8') ?></h1>
        <p>ADAPT project is ready.</p>
    </main>
    <script src="/assets/js/app.js"></script>
</body>
</html>
