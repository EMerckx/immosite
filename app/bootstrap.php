<?php

// Require Composer Autoloader
require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR . 'autoload.php';
require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'includes' . DIRECTORY_SEPARATOR . 'config.php';

// Create new Silex App
$app = new Silex\Application();

// App Configuration
$app['debug'] = true;

// Use Twig — @note: Be sure to install Twig via Composer first!
$app->register(new Silex\Provider\TwigServiceProvider(), array(
	'twig.path' => __DIR__ .  DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . 'views'
));

// Use Doctrine — @note: Be sure to install Doctrine via Composer first!
$app->register(new Silex\Provider\DoctrineServiceProvider(), array(
    'db.options' => array(
        'dbname' => DB_NAME,
        'user' => DB_USER,
        'password' => DB_PASS,
        'host' => DB_HOST,
        'driver' => 'pdo_mysql',
    )
));

// Use Repository Service Provider — @note: Be sure to install RSP via Composer first!
$app->register(new Knp\Provider\RepositoryServiceProvider(), array(
    'repository.repositories' => array(
        'auth' => 'Ikdoeict\\Repository\\AuthRepository',
        'immo' => 'Ikdoeict\\Repository\\ImmoRepository'
    )
));

// Use UrlGenerator Service Provider - @note: Be sure to install "symfony/twig-bridge" via Composer if you want to use the `url` & `path` functions in Twig
$app->register(new Silex\Provider\UrlGeneratorServiceProvider());

// Use Validator Service Provider - @note: Be sure to install "symfony/validator" via Composer first!
$app->register(new Silex\Provider\ValidatorServiceProvider());

// Use Form Service Provider - @note: Be sure to install "symfony/form" & "symfony/twig-bridge" via Composer first!
$app->register(new Silex\Provider\FormServiceProvider());

// Use Translation Service Provider because without it our form won't work
$app->register(new Silex\Provider\TranslationServiceProvider(), array(
	'translator.messages' => array(),
));

// Use Swiftmailer Service Provider
$app->register(new Silex\Provider\SwiftmailerServiceProvider(), array(
    'swiftmailer.options' => array(
        'host' => 'smtp.gmail.com',
        'port' => '465',
        'username' => 'praxisewoutmerckx@gmail.com',
        'password' => 'Azerty321',
        'encryption' => 'ssl',
        'transport' => 'gmail'
    )
));

// Use Session Service Provider
$app->register(new Silex\Provider\SessionServiceProvider());

// Use Config Service Provider
//$app->register(new Igorw\Silex\ConfigServiceProvider(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'includes' . DIRECTORY_SEPARATOR . 'config.php'));