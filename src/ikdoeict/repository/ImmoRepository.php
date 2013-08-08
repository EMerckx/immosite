<?php

namespace Ikdoeict\Repository;

class ImmoRepository extends \Knp\Repository
{
    public function getTableName()
    {
        return 'real_estate';
    }

    public function getImmos($userId, $limit, $startindex)
    {
        return $this->db->fetchAll('SELECT real_estate.ID AS real_estate_id, type, categories.name AS category_name, address_streetnr, address_city, countries.name AS country_name, area, bedrooms, visible, price
        FROM real_estate INNER JOIN categories ON real_estate.categories_ID = categories.ID
        INNER JOIN countries ON real_estate.countries_code = countries.code
        WHERE companies_ID = ?
        ORDER BY real_estate.ID DESC
        LIMIT ' . ((int)$limit) . ' offset ' . ((int)$startindex),
            array($userId));
    }

    public function getAmountImmos($userId)
    {
        $result = $this->db->fetchAssoc('SELECT COUNT(*) AS total_immos
        FROM real_estate
        WHERE companies_ID = ?',
            array($userId));
        return $result['total_immos'];
    }

    public function getCategories()
    {
        $categories = $this->db->fetchAll('SELECT name FROM categories ORDER BY name');
        if (!$categories) {
            $categoryChoices = array("1" => "No countries available");
        } else {
            foreach ($categories as $category) {
                $categoryChoices[] = $category['name'];
            }
        }
        return $categoryChoices;
    }

    public function createImmo($userId, $type, $price, $category, $streetnr, $postcode, $city, $country, $bedrooms, $area, $ki, $visibility, $description){
        $this->db->executeQuery('INSERT INTO real_estate (companies_ID, type, price, categories_ID, address_streetnr, address_postcode, address_city, countries_code, bedrooms, area, ki, visible, description)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', array($userId, $type, $price, $category, $streetnr, $postcode, $city, $country, $bedrooms, $area, $ki, $visibility, $description));

        $id = $this->db->fetchAssoc('SELECT MAX(ID) AS id FROM real_estate WHERE companies_ID = ?', array($userId));
        return $id['id'];
    }

    public function getCategoryId($categoryName){
        $category = $this->db->fetchAssoc('SELECT ID
        FROM categories
        WHERE name = ?', array($categoryName));

        return $category['ID'];
    }

    public function getCategory($categoryId){
        $category = $this->db->fetchAssoc('SELECT name
        FROM categories
        WHERE ID = ?', array($categoryId));

        return $category['name'];
    }

    public function getCountryCode($countryName){
        $country = $this->db->fetchAssoc('SELECT code
        FROM countries
        WHERE name = ?', array($countryName));

        return $country['code'];
    }

    public function getImmo($immoId, $userId)
    {
        return $this->db->fetchAssoc('SELECT ID AS real_estate_id, address_streetnr, address_postcode, address_city, name AS country_name, companies_ID
        FROM real_estate INNER JOIN countries ON real_estate.countries_code = countries.code
        WHERE ID = ? AND companies_ID = ?', array($immoId, $userId));
    }

    public function updateImmo($immoId, $userId, $type, $price, $category, $streetnr, $postcode, $city, $country, $bedrooms, $area, $ki, $visibility, $description){
        return $this->db->executeQuery('UPDATE real_estate
        SET type = ?, price = ?, categories_ID = ?, address_streetnr = ?, address_postcode = ?, address_city = ?, countries_code = ?, bedrooms = ?, area = ?, ki = ?, visible = ?, description = ?
        WHERE ID = ? AND companies_ID = ?',
            array($type, $price, $category, $streetnr, $postcode, $city, $country, $bedrooms, $area, $ki, $visibility, $description, $immoId, $userId));
    }

    public function deleteImmo($immoId, $userId){
        return $this->db->executeQuery('DELETE FROM real_estate
        WHERE ID = ? AND companies_ID = ?',
            array($immoId, $userId));
    }

    public function getImmoDetail($immoId, $userId){
        return $this->db->fetchAssoc('SELECT real_estate.ID AS real_estate_id, type, categories.name AS category_name, address_streetnr, address_postcode, address_city, countries.name AS country_name, area, bedrooms, visible, price, ki, description, companies_ID
        FROM real_estate INNER JOIN categories ON real_estate.categories_ID = categories.ID
        INNER JOIN countries ON real_estate.countries_code = countries.code
        WHERE real_estate.ID = ? AND companies_ID = ?',
            array($immoId, $userId));
    }

    public function getCompany($companyId){
        return $this->db->fetchAssoc('SELECT ID, companies.name AS company_name, contact_tel, address_streetnr, address_postcode, address_city, countries.name AS country_name
        FROM companies INNER JOIN countries ON companies.countries_code = countries.code
        WHERE companies.ID = ?',
            array($companyId));
    }
}