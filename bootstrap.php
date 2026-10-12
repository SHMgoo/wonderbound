<?php

declare(strict_types=1);

define('APP_ROOT', __DIR__);
define('SRC_ROOT', APP_ROOT . '/src');
define('CONFIG_ROOT', APP_ROOT . '/config');

// Application-specific environment loading and shared support
// initialization can be added as the project is developed.
$appConfig = require CONFIG_ROOT . '/config.php';
