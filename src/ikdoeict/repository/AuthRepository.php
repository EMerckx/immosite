<?php

namespace Ikdoeict\Repository;

class AuthRepository extends \Knp\Repository
{

    public function getTableName()
    {
        return 'companies';
    }

    public function getUser($userName)
    {
        return $this->db->fetchAssoc('SELECT ID, contact_name, password  FROM companies WHERE contact_email = ?', array($userName));
    }

    public function getUserId($userName){
        return $this->db->fetchAssoc('SELECT ID, contact_name FROM companies WHERE contact_email = ?', array($userName));
    }

    public function createUser($name, $description, $contact_email, $password, $contact_name, $contact_tel, $address_streetnr, $address_postcode, $address_city, $country)
    {
        $this->db->executeQuery('INSERT INTO companies (name, description, contact_email, password, contact_name, contact_tel, address_streetnr, address_postcode, address_city, countries_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, (SELECT code FROM countries WHERE name = ? ))', array($name, $description, $contact_email, $password, $contact_name, $contact_tel, $address_streetnr, $address_postcode, $address_city, $country));
    }

    public function  getCountries() {
        $countries = $this->db->fetchAll('SELECT name FROM countries ORDER BY name');
        if(!$countries){
            $countryChoices = array("1" => "No countries available");
        }
        else {
            foreach($countries as $country){
                $countryChoices[] = $country['name'];
            }
        }
        return $countryChoices;
    }

    public function getCountry($countryCode){
        $country = $this->db->fetchAssoc('SELECT name
        FROM countries
        WHERE code = ?', array($countryCode));

        return $country['name'];
    }

    public function getCompany($companyId){
        return $this->db->fetchAssoc('SELECT companies.name AS company_name, description, contact_name AS name, contact_email, contact_tel , address_streetnr, address_postcode, address_city, countries.name AS country_name
        FROM companies INNER JOIN countries ON companies.countries_code = countries.code
        WHERE ID = ?',
            array($companyId));
    }

    public function updateCompany($companyId, $name, $description, $contact_email, $contact_name, $contact_tel, $address_streetnr, $address_postcode, $address_city, $country)
    {
        $this->db->executeQuery('UPDATE companies
        SET name = ?, description = ?, contact_email = ?, contact_name = ?, contact_tel = ?, address_streetnr = ?, address_postcode = ?, address_city = ?, countries_code = (SELECT code FROM countries WHERE name = ? )
        WHERE ID = ?',
            array($name, $description, $contact_email, $contact_name, $contact_tel, $address_streetnr, $address_postcode, $address_city, $country, $companyId));
    }
}