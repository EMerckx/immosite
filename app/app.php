<?php

// Bootstrap
require __DIR__ . DIRECTORY_SEPARATOR . 'bootstrap.php';

// Use Request from Symfony Namespace
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

$app->error(function (\Exception $e, $code) use ($app) {
	if ($code == 404) {
		return $app['twig']->render('errors/404.twig', array('error' => $e->getMessage()));
	} else {
		return 'Shenanigans! Something went horribly wrong // ' . $e->getMessage();
	}
});

$app->get('/', function(Silex\Application $app) {
    return $app->redirect($app['request']->getBaseUrl() . '/immo/browse');
});

// Define routes for our static pages
$pages = array(
	'/' => 'home'
);
foreach ($pages as $route => $view) {
	$app->get($route, function () use ($app, $view) {
		return $app['twig']->render('static/' . $view . '.twig', array('user' => $app['session']->get('user'), 'query' => ""));
	})->bind($view);
}

// Mount our controllers (dynamic routes)
$app->mount('/auth', new Ikdoeict\Provider\Controller\AuthController());
$app->mount('/immo', new Ikdoeict\Provider\Controller\ImmoController());