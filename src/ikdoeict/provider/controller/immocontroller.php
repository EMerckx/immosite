<?php

namespace Ikdoeict\Provider\Controller;

use Silex\Application;
use Silex\ControllerProviderInterface;
use Silex\ControllerCollection;
use Symfony\Component\Validator\Constraints as Assert;

class ImmoController implements ControllerProviderInterface
{

    public function connect(Application $app)
    {
        $controllers = $app['controllers_factory'];

        $controllers->get('/', function (Application $app) {
            return $app->redirect($app['url_generator']->generate('immo.browse'));
        });

        $controllers->match('/browse/', array($this, 'browse'))->method('GET|POST')->bind('immo.browse');
        $controllers->match('/insert/', array($this, 'insert'))->method('GET|POST')->bind('immo.insert');
        $controllers->get('/browse/{immoId}/', array($this, 'detail'))->assert('immoId', '\d+');
        $controllers->match('/browse/{immoId}/edit/', array($this, 'edit'))->method('GET|POST')->bind('immo.edit')->assert('immoId', '\d+');
        $controllers->match('/browse/{immoId}/upload', array($this, 'upload'))->method('GET|POST')->bind('immo.upload')->assert('immoId', '\d+');
        $controllers->match('/browse/{immoId}/delete/', array($this, 'delete'))->method('GET|POST')->bind('immo.delete')->assert('immoId', '\d+');

        return $controllers;
    }

    public function browse(Application $app)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $pagination = array();
        if ('GET' == $app['request']->getMethod()) {
            $shownImmos = 10;
            $startIndex = isset($_GET['page']) && $_GET['page'] >= 1 ? ($_GET['page'] - 1) * 10 : 0;
        }

        $immos = $app['immo']->getImmos($user['id'], $shownImmos, $startIndex);
        $amountOfImmos = $app['immo']->getAmountImmos($user['id']);

        $pages = (int)((int)$amountOfImmos / $shownImmos + 1);
        for ($i = 1; $i <= $pages; $i++) {
            $url = preg_replace('/(&page=)([0-9]+)/', '', $_SERVER['QUERY_STRING']);
            $pagination[$i]['pagenumber'] = $i;
            $pagination[$i]['url'] = '?' . $url . '&page=' . $i;
        }

        return $app['twig']->render('immo/browse.twig', array('immos' => $immos, 'user' => $user, 'pagination' => $pagination));
    }

    public function detail(Application $app, $immoId)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $immo = $app['immo']->getImmoDetail($immoId, $user['id']);
        if ($immo) {
            if ($user['id'] != $immo['companies_ID']) {
                return $app->redirect($app['url_generator']->generate('immo.browse'));
            }

            $company = $app['immo']->getCompany($immo['companies_ID']);

            $logo = [];
            $di = new \DirectoryIterator($app['auth.base_path']);
            foreach ($di as $file) {
                if ($file->getExtension() == 'jpg' && $file->getFileName() == $immo['companies_ID'] . '.jpg') {
                    $logo[] = array(
                        'url' => $app['auth.base_url'] . $file,
                        'title' => $company['company_name']
                    );
                }
            }

            $photos = [];
            $di = new \DirectoryIterator($app['immo.base_path'] . $immoId);
            foreach ($di as $file) {
                if ($file->getExtension() == 'jpg') {
                    $photos[] = array(
                        'url' => $app['immo.base_url'] . $immoId . '/' . $file,
                        'title' => $file->getFileName()
                    );
                }
            }

            return $app['twig']->render('immo/detail.twig', array('immo' => $immo, 'user' => $user, 'company' => $company, 'logos' => $logo, 'photos' => $photos));
        } else {
            return $app->redirect($app['url_generator']->generate('immo.browse'));
        }
    }

    public function insert(Application $app)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }
        $countryChoices = $app['auth']->getCountries();
        $categoryChoices = $app['immo']->getCategories();

        // Create Form
        $insertform = $app['form.factory']->createNamed('insertform')
            ->add('type', 'choice', array(
                'constraints' => array(new Assert\NotBlank()),
                'choices' => array('S' => 'for sale', 'R' => 'for rent'),
                'required' => false,
                'data' => 'S'
            ))
            ->add('price', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('category', 'choice', array(
                'constraints' => array(new Assert\NotBlank()),
                'choices' => $categoryChoices,
                'required' => false
            ))
            ->add('street_and_number', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('postal_code', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('city', 'text', array(
                'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                'required' => false
            ))
            ->add('country', 'choice', array(
                'constraints' => array(new Assert\NotBlank()),
                'choices' => $countryChoices,
                'required' => false
            ))

            ->add('amount_of_bedrooms', 'text', array(
                'required' => false
            ))
            ->add('area', 'text', array(
                'required' => false
            ))
            ->add('K_I', 'text', array(
                'required' => false
            ))
            ->add('visibility', 'choice', array(
                'constraints' => array(new Assert\NotBlank()),
                'choices' => array('Y' => 'visible', 'N' => 'invisible'),
                'required' => false,
                'data' => 'Y'
            ))
            ->add('description', 'textarea', array(
                'required' => false
            ));

        // Form was submitted: process it
        if ('POST' == $app['request']->getMethod()) {
            $insertform->bind($app['request']);

            if ($insertform->isValid()) {
                $data = $insertform->getData();

                $categoryId = $app['immo']->getCategoryId($categoryChoices[$data['category']]);
                $countryCode = $app['immo']->getCountryCode($countryChoices[$data['country']]);

                $insertedId = $app['immo']->createImmo($user['id'], $data['type'], $data['price'], $categoryId, $data['street_and_number'], $data['postal_code'], $data['city'], $countryCode, $data['amount_of_bedrooms'], $data['area'], $data['K_I'], $data['visibility'], $data['description']);
                mkdir('' . $app['immo.base_path'] . $insertedId);

                return $app->redirect($app['url_generator']->generate('immo.browse') . '?inserted');
            }
        }

        return $app['twig']->render('immo/insert.twig', array('insertform' => $insertform->createView(), 'user' => $user));
    }

    public function edit(Application $app, $immoId)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $immo = $app['immo']->getImmoDetail($immoId, $user['id']);
        if ($immo) {
            if ($user['id'] != $immo['companies_ID']) {
                return $app->redirect($app['url_generator']->generate('immo.browse'));
            }

            $countryChoices = $app['auth']->getCountries();
            $countryIndex = array_search($immo['country_name'], $countryChoices);
            $countryIndex == false ? -1 : $countryIndex;

            $categoryChoices = $app['immo']->getCategories();
            $categoryIndex = array_search($immo['category_name'], $categoryChoices);
            $categoryIndex == false ? -1 : $categoryIndex;

            // Create Form
            $insertform = $app['form.factory']->createNamed('insertform')
                ->add('type', 'choice', array(
                    'constraints' => array(new Assert\NotBlank()),
                    'choices' => array('S' => 'for sale', 'R' => 'for rent'),
                    'required' => false,
                    'data' => $immo['type']
                ))
                ->add('price', 'text', array(
                    'constraints' => array(new Assert\NotBlank()),
                    'required' => false,
                    'data' => $immo['price']
                ))
                ->add('category', 'choice', array(
                    'constraints' => array(new Assert\NotBlank()),
                    'choices' => $categoryChoices,
                    'required' => false,
                    'data' => $categoryIndex
                ))
                ->add('street_and_number', 'text', array(
                    'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                    'required' => false,
                    'data' => $immo['address_streetnr']
                ))
                ->add('postal_code', 'text', array(
                    'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                    'required' => false,
                    'data' => $immo['address_postcode']
                ))
                ->add('city', 'text', array(
                    'constraints' => array(new Assert\NotBlank(), new Assert\Length(array('min' => 2))),
                    'required' => false,
                    'data' => $immo['address_city']
                ))
                ->add('country', 'choice', array(
                    'constraints' => array(new Assert\NotBlank()),
                    'choices' => $countryChoices,
                    'required' => false,
                    'data' => $countryIndex
                ))

                ->add('amount_of_bedrooms', 'text', array(
                    'required' => false,
                    'data' => $immo['bedrooms']
                ))
                ->add('area', 'text', array(
                    'required' => false,
                    'data' => $immo['area']
                ))
                ->add('K_I', 'text', array(
                    'required' => false,
                    'data' => $immo['ki']
                ))
                ->add('visibility', 'choice', array(
                    'constraints' => array(new Assert\NotBlank()),
                    'choices' => array('Y' => 'visible', 'N' => 'invisible'),
                    'required' => false,
                    'data' => $immo['visible']
                ))
                ->add('description', 'textarea', array(
                    'required' => false,
                    'data' => $immo['description']
                ));

            //Form was submitted: process it
            if ('POST' == $app['request']->getMethod()) {
                $insertform->bind($app['request']);

                if ($insertform->isValid()) {
                    $data = $insertform->getData();

                    $categoryId = $app['immo']->getCategoryId($categoryChoices[$data['category']]);
                    $countryCode = $app['immo']->getCountryCode($countryChoices[$data['country']]);

                    $app['immo']->updateImmo($immo['real_estate_id'], $user['id'], $data['type'], $data['price'], $categoryId, $data['street_and_number'], $data['postal_code'], $data['city'], $countryCode, $data['amount_of_bedrooms'], $data['area'], $data['K_I'], $data['visibility'], $data['description']);
                    return $app->redirect($app['url_generator']->generate('immo.browse') . $immo['real_estate_id'] . '/?updated');
                }
            }

            return $app['twig']->render('immo/edit.twig', array('user' => $user, 'insertform' => $insertform->createView(), 'immo' => $immo));
        } else {
            return $app->redirect($app['url_generator']->generate('immo.browse'));
        }
    }

    public function upload(Application $app, $immoId)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $immo = $app['immo']->getImmo($immoId, $user['id']);
        if ($immo) {
            if ($user['id'] != $immo['companies_ID']) {
                return $app->redirect($app['url_generator']->generate('immo.browse'));
            }

            // Create Upload Form
            $uploadform = $app['form.factory']->createNamed('uploadform')
                ->add('photo', 'file', array(
                    'constraints' => new Assert\NotBlank()
                ));
            //Form was submitted: process it
            if ('POST' == $app['request']->getMethod()) {
                $uploadform->bind($app['request']);
                if ($uploadform->isValid()) {
                    $data = $uploadform->getData();
                    $files = $app['request']->files->get($uploadform->getName());

                    // Uploaded file must be `.jpg`!
                    if (isset($files['photo']) && ('.jpg' == substr($files['photo']->getClientOriginalName(), -4))) {

                        // Define the new name (files are named sequentially)
                        $nextAvailableNumberInBasePath = 1;
                        $di = new \DirectoryIterator($app['immo.base_path'] . $immoId);
                        foreach ($di as $file) {
                            if ($file->getExtension() == 'jpg') $nextAvailableNumberInBasePath++;
                        }

                        // Move it to its new location
                        $files['photo']->move($app['immo.base_path'] . $immoId . DIRECTORY_SEPARATOR, $nextAvailableNumberInBasePath . '.jpg');

                        return $app->redirect($app['url_generator']->generate('immo.browse') . $immoId . '/?uploaded');
                    } else {
                        $uploadform->get('photo')->addError(new \Symfony\Component\Form\FormError('Only .jpg allowed'));
                    }
                }
            }

            return $app['twig']->render('immo/upload.twig', array('user' => $user, 'immo' => $immo, 'uploadform' => $uploadform->createView()));
        } else {
            return $app->redirect($app['url_generator']->generate('immo.browse'));
        }
    }

    public function delete(Application $app, $immoId)
    {
        $user = $app['session']->get('user');
        if ($user == false) {
            return $app->redirect($app['url_generator']->generate('auth.login'));
        }

        $immo = $app['immo']->getImmo($immoId, $user['id']);
        if ($immo) {
            if ($user['id'] != $immo['companies_ID']) {
                return $app->redirect($app['url_generator']->generate('immo.browse'));
            }

            if ('POST' == $app['request']->getMethod()) {
                $app['immo']->deleteImmo($immoId, $user['id']);
                self::deleteDir('' . $app['immo.base_path'] . $immoId);
                return $app->redirect($app['url_generator']->generate('immo.browse'));
            }

            return $app['twig']->render('immo/delete.twig', array('immo' => $immo, 'user' => $user));

        } else {
            return $app->redirect($app['url_generator']->generate('immo.browse'));
        }
    }

    // source : http://stackoverflow.com/questions/3349753/delete-directory-with-files-in-it
    private static function deleteDir($dirPath) {
        if (! is_dir($dirPath)) {
            throw new InvalidArgumentException("$dirPath must be a directory");
        }
        if (substr($dirPath, strlen($dirPath) - 1, 1) != '/') {
            $dirPath .= '/';
        }
        $files = glob($dirPath . '*', GLOB_MARK);
        foreach ($files as $file) {
            if (is_dir($file)) {
                self::deleteDir($file);
            } else {
                unlink($file);
            }
        }
        rmdir($dirPath);
    }
}