<?php

namespace Ikdoeict\Provider\Controller;

use Silex\Application;
use Silex\ControllerProviderInterface;
use Silex\ControllerCollection;
use Symfony\Component\Validator\Constraints as Assert;

class AuthController implements ControllerProviderInterface
{

    public function connect(Application $app)
    {
        $controllers = $app['controllers_factory'];

        $controllers->get('/', function (Application $app) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        });

        $controllers
            ->match('/login/', array($this, 'login'))
            ->method('GET|POST')
            ->bind('auth.login');
        $controllers->get('/logout/', array($this, 'logout'))->assert('id', '\d+')->bind('auth.logout');
        $controllers->match('/register/', array($this, 'register'))->method('GET|POST')->bind('auth.register');

        $controllers
            ->get('/profile/', array($this, 'profile'))
            ->assert('id', '\d+')
            ->bind('auth.profile');
        $controllers
            ->match('/profile/edit/', array($this, 'editProfile'))
            ->method('GET|POST')
            ->bind('auth.editprofile');
        $controllers
            ->match('/profile/upload/', array($this, 'upload'))
            ->method('GET|POST')
            ->bind('auth.upload');

        return $controllers;
    }

    public function login(Application $app)
    {
        // Already logged in
        if ($app['session']->get('user')) {
            return $app->redirect($app['url_generator']->generate('home'));
        }

        // Create Form
        $loginform = $app['form.factory']->createNamed('loginform')
            ->add('username', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5))),
                'required' => false
            ))
            ->add('password', 'password', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5))),
                'required' => false
            ));

        // Form was submitted: process it
        if ('POST' == $app['request']->getMethod()) {
            $loginform->bind($app['request']);

            if ($loginform->isValid()) {
                $data = $loginform->getData();

                $user = $app['auth']->getUser($data['username']);
                if ($user) {
                    $password = sha1($data['password'] . PASSWORD_SALT);
                    if ($user['password'] == $password) {

                        $app['session']->set('user', array(
                            'id' => $user['ID'],
                            'name' => $user['contact_name']
                        ));

                        return $app->redirect($app['url_generator']->generate('home'));
                    } else {
                        $loginform->get('password')->addError(new \Symfony\Component\Form\FormError('Invalid password'));
                    }
                } else {
                    $loginform->get('username')->addError(new \Symfony\Component\Form\FormError('Invalid username'));
                }
            }
        }

        return $app['twig']->render('auth/login.twig', array('loginform' => $loginform->createView(), 'user' => array(), 'query' => ""));
    }


    public function logout(Application $app)
    {
        $app['session']->remove('user');
        return $app->redirect($app['url_generator']->generate('auth.login') . '?loggedout');
    }

    public function register(Application $app)
    {
        // Already logged in
        if ($app['session']->get('user')) {
            return $app->redirect($app['url_generator']->generate('home'));
        }

        $countryChoices = $app['auth']->getCountries();

        // Create Form
        $registerform = $app['form.factory']->createNamed('registerform')
            ->add('company_name', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('description', 'textarea')

            ->add('email', 'email', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5)), new Assert\Email()),
                'required' => false
            ))
            ->add('password', 'password', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5))),
                'required' => false
            ))
            ->add('confirm_password', 'password', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5))),
                'required' => false
            ))

            ->add('name', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('telephone_number', 'text', array(
                'required' => false,
                'constraints' => array(new Assert\NotBlank())
            ))
            ->add('street_and_number', 'text', array(
                'required' => false
            ))
            ->add('postal_code', 'text', array(
                'required' => false
            ))
            ->add('city', 'text', array(
                'required' => false
            ))
            ->add('country', 'choice', array(
                'choices' => $countryChoices,
                'required' => false
            ));

        if ('POST' == $app['request']->getMethod()) {
            $registerform->bind($app['request']);

            if ($registerform->isValid()) {
                $data = $registerform->getData();

                $user = $app['auth']->getUserId($data['email']);
                if (!$user) {
                    if ($data['password'] == $data['confirm_password']) {
                        $password = sha1($data['password'] . PASSWORD_SALT);
                        $app['auth']->createUser($data['company_name'], $data['description'], $data['email'], $password, $data['name'], $data['telephone_number'], $data['street_and_number'], $data['postal_code'], $data['city'], $countryChoices[$data['country']]);

                        $user = $app['auth']->getUserId($data['email']);
                        if ($user) {
                            $app['session']->set('user', array(
                                'id' => $user['ID'],
                                'name' => $user['contact_name']
                            ));

                            return $app->redirect($app['url_generator']->generate('home'));
                        }

                        return $app->redirect($app['url_generator']->generate('auth.login') . '?registrated');
                    } else {
                        $registerform->get('confirmpassword')->addError(new \Symfony\Component\Form\FormError('Password doesn\'t match.'));
                    }
                } else {
                    $registerform->get('email')->addError(new \Symfony\Component\Form\FormError('User already exists'));
                }
            }
        }

        // Form was submitted: process it
        if ('POST' == $app['request']->getMethod()) {
            $loginform->bind($app['request']);

            if ($loginform->isValid()) {
                $data = $loginform->getData();

                $user = $app['auth']->getUser($data['username']);
                if ($user) {
                    $password = sha1($data['password'] . PASSWORD_SALT);
                    if ($user['password'] == $password) {

                        $app['session']->set('user', array(
                            'id' => $user['ID'],
                            'name' => $user['contact_name']
                        ));

                        return $app->redirect($app['url_generator']->generate('home'));
                    } else {
                        $loginform->get('password')->addError(new \Symfony\Component\Form\FormError('Invalid password'));
                    }
                } else {
                    $loginform->get('username')->addError(new \Symfony\Component\Form\FormError('Invalid username'));
                }
            }
        }


        return $app['twig']->render('auth/register.twig', array('registerform' => $registerform->createView(), 'user' => array()));
    }

    public function profile(Application $app)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $company = $app['auth']->getCompany($user['id']);

        $logo = [];
        $di = new \DirectoryIterator($app['auth.base_path']);
        foreach ($di as $file) {
            if ($file->getExtension() == 'jpg' && $file->getFileName() == $user['id'] . '.jpg') {
                $logo[] = array(
                    'url' => $app['auth.base_url'] . $file,
                    'title' => $company['company_name']
                );
            }
        }

        return $app['twig']->render('auth/profile.twig', array('user' => $user, 'company' => $company, 'logos' => $logo));
    }

    public function editProfile(Application $app)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $countryChoices = $app['auth']->getCountries();
        $company = $app['auth']->getCompany($user['id']);

        $countryIndex = array_search($company['country_name'], $countryChoices);
        $countryIndex = $countryIndex == false ? -1 : $countryIndex;

        // Create Form
        $registerform = $app['form.factory']->createNamed('registerform')
            ->add('company_name', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false,
                'data' => $company['company_name']
            ))
            ->add('description', 'textarea', array(
                'data' => $company['description']
            ))

            ->add('email', 'email', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 5)), new Assert\Email()),
                'required' => false,
                'data' => $company['contact_email']
            ))

            ->add('name', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false,
                'data' => $company['name']
            ))
            ->add('telephone_number', 'text', array(
                'required' => false,
                'constraints' => array(new Assert\NotBlank()),
                'data' => $company['contact_tel']
            ))
            ->add('street_and_number', 'text', array(
                'required' => false,
                'data' => $company['address_streetnr']
            ))
            ->add('postal_code', 'text', array(
                'required' => false,
                'data' => $company['address_postcode']
            ))
            ->add('city', 'text', array(
                'required' => false,
                'data' => $company['address_city']
            ))
            ->add('country', 'choice', array(
                'choices' => $countryChoices,
                'required' => false,
                'data' => $countryIndex,
                'constraints' => array(new Assert\NotBlank())
            ));

        if ('POST' == $app['request']->getMethod()) {
            $registerform->bind($app['request']);

            if ($registerform->isValid()) {
                $data = $registerform->getData();

                $app['auth']->updateCompany($user['id'], $data['company_name'], $data['description'], $data['email'], $data['name'], $data['telephone_number'], $data['street_and_number'], $data['postal_code'], $data['city'], $countryChoices[$data['country']]);
                $app['session']->set('user', array(
                    'id' => $user['id'],
                    'name' => $data['name']
                ));
                return $app->redirect($app['url_generator']->generate('auth.profile') . '?updated');
            }
        }

        return $app['twig']->render('auth/editprofile.twig', array('registerform' => $registerform->createView(), 'user' => $user));
    }

    public function upload(Application $app)
    {

        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        // Create Upload Form
        $uploadform = $app['form.factory']->createNamed('uploadform')
            ->add('logo', 'file', array(
                'constraints' => new Assert\NotBlank()
            ));

        // Form was submitted: process it
        if ('POST' == $app['request']->getMethod()) {
            $uploadform->bind($app['request']);

            if ($uploadform->isValid()) {
                $data = $uploadform->getData();
                $files = $app['request']->files->get($uploadform->getName());

                // Uploaded file must be `.jpg`!
                if (isset($files['logo']) && ('.jpg' == substr($files['logo']->getClientOriginalName(), -4))) {

                    // Move it to its new location
                    $files['logo']->move($app['auth.base_path'], $user['id'] . '.jpg');

                    // Redirec to the overview
                    return $app->redirect($app['url_generator']->generate('auth.profile'));

                } else {
                    $uploadform->get('logo')->addError(new \Symfony\Component\Form\FormError('Only .jpg allowed'));
                }
            }
        }

        return $app['twig']->render('auth/upload.twig', array('user' => $user, 'uploadform' => $uploadform->createView()));
    }


}