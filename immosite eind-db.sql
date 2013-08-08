-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Machine: localhost
-- Genereertijd: 08 aug 2013 om 12:50
-- Serverversie: 5.6.12-log
-- PHP-versie: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databank: `immosite`
--
CREATE DATABASE IF NOT EXISTS `immosite` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `immosite`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Gegevens worden uitgevoerd voor tabel `categories`
--

INSERT INTO `categories` (`ID`, `name`) VALUES
(1, 'Houses'),
(2, 'Apartments'),
(3, 'Land'),
(4, 'Businesses'),
(5, 'Offices'),
(6, 'Industries'),
(7, 'Garages'),
(8, 'Rental complexes');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `companies`
--

CREATE TABLE IF NOT EXISTS `companies` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `contact_name` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address_streetnr` varchar(255) DEFAULT NULL,
  `address_postcode` varchar(255) DEFAULT NULL,
  `address_city` varchar(255) DEFAULT NULL,
  `contact_tel` varchar(255) NOT NULL,
  `countries_code` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_companies_countries_idx` (`countries_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Gegevens worden uitgevoerd voor tabel `companies`
--

INSERT INTO `companies` (`ID`, `name`, `description`, `contact_name`, `contact_email`, `password`, `address_streetnr`, `address_postcode`, `address_city`, `contact_tel`, `countries_code`) VALUES
(1, 'immoweb.be', '<p>Immoweb is the foremost Belgian property site. We are unquestionably the leader in the Belgian property market. Immoweb has been in existence since 1996 and covers the entire Belgian territory.</p>\r\n<p>If you wish to see how many people have faith in us every day, visit the CIM site at M&eacute;triweb, the official body responsible for authenticating the number of visitors to the main Belgian websites.</p>\r\n<p>Immoweb is a member of the Produpress Group.</p>', 'Mark Peeters', 'info@immoweb.be', '1b55117a925421af38a19dc9e1a038d936c0ad86', 'Avenue GÃ©nÃ©ral Dumonceau 56', 'B-1190', 'Forest', '+3223/33.25.05', 'BE'),
(2, 'Zimmo', '<p>This is probably the best real estate agency in the world.</p>', 'Christoph Leekers', 'info@zimmo.com', '1b55117a925421af38a19dc9e1a038d936c0ad86', 'Gentsesteenweg 24', '9300', 'Aalst', '+32486/32.45.99', 'BE');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `code` varchar(2) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Gegevens worden uitgevoerd voor tabel `countries`
--

INSERT INTO `countries` (`code`, `name`) VALUES
('AD', 'Andorra'),
('AE', 'United Arab Emirates'),
('AF', 'Afghanistan'),
('AG', 'Antigua and Barbuda'),
('AI', 'Anguilla'),
('AL', 'Albania'),
('AM', 'Armenia'),
('AN', 'Netherlands Antilles'),
('AO', 'Angola'),
('AQ', 'Antarctica'),
('AR', 'Argentina'),
('AS', 'American Samoa'),
('AT', 'Austria'),
('AU', 'Australia'),
('AW', 'Aruba'),
('AZ', 'Azerbaijan'),
('BA', 'Bosnia and Herzegovina'),
('BB', 'Barbados'),
('BD', 'Bangladesh'),
('BE', 'Belgium'),
('BF', 'Burkina Faso'),
('BG', 'Bulgaria'),
('BH', 'Bahrain'),
('BI', 'Burundi'),
('BJ', 'Benin'),
('BM', 'Bermuda'),
('BN', 'Brunei Darussalam'),
('BO', 'Bolivia'),
('BR', 'Brazil'),
('BS', 'Bahamas'),
('BT', 'Bhutan'),
('BV', 'Bouvet Island'),
('BW', 'Botswana'),
('BY', 'Belarus'),
('BZ', 'Belize'),
('CA', 'Canada'),
('CC', 'Cocos (Keeling) Islands'),
('CD', 'Congo, the Democratic Republic of the'),
('CF', 'Central African Republic'),
('CG', 'Congo'),
('CH', 'Switzerland'),
('CI', 'Cote D''Ivoire'),
('CK', 'Cook Islands'),
('CL', 'Chile'),
('CM', 'Cameroon'),
('CN', 'China'),
('CO', 'Colombia'),
('CR', 'Costa Rica'),
('CS', 'Serbia and Montenegro'),
('CU', 'Cuba'),
('CV', 'Cape Verde'),
('CX', 'Christmas Island'),
('CY', 'Cyprus'),
('CZ', 'Czech Republic'),
('DE', 'Germany'),
('DJ', 'Djibouti'),
('DK', 'Denmark'),
('DM', 'Dominica'),
('DO', 'Dominican Republic'),
('DZ', 'Algeria'),
('EC', 'Ecuador'),
('EE', 'Estonia'),
('EG', 'Egypt'),
('EH', 'Western Sahara'),
('ER', 'Eritrea'),
('ES', 'Spain'),
('ET', 'Ethiopia'),
('FI', 'Finland'),
('FJ', 'Fiji'),
('FK', 'Falkland Islands (Malvinas)'),
('FM', 'Micronesia, Federated States of'),
('FO', 'Faroe Islands'),
('FR', 'France'),
('GA', 'Gabon'),
('GB', 'United Kingdom'),
('GD', 'Grenada'),
('GE', 'Georgia'),
('GF', 'French Guiana'),
('GH', 'Ghana'),
('GI', 'Gibraltar'),
('GL', 'Greenland'),
('GM', 'Gambia'),
('GN', 'Guinea'),
('GP', 'Guadeloupe'),
('GQ', 'Equatorial Guinea'),
('GR', 'Greece'),
('GS', 'South Georgia and the South Sandwich Islands'),
('GT', 'Guatemala'),
('GU', 'Guam'),
('GW', 'Guinea-Bissau'),
('GY', 'Guyana'),
('HK', 'Hong Kong'),
('HM', 'Heard Island and Mcdonald Islands'),
('HN', 'Honduras'),
('HR', 'Croatia'),
('HT', 'Haiti'),
('HU', 'Hungary'),
('ID', 'Indonesia'),
('IE', 'Ireland'),
('IL', 'Israel'),
('IN', 'India'),
('IO', 'British Indian Ocean Territory'),
('IQ', 'Iraq'),
('IR', 'Iran, Islamic Republic of'),
('IS', 'Iceland'),
('IT', 'Italy'),
('JM', 'Jamaica'),
('JO', 'Jordan'),
('JP', 'Japan'),
('KE', 'Kenya'),
('KG', 'Kyrgyzstan'),
('KH', 'Cambodia'),
('KI', 'Kiribati'),
('KM', 'Comoros'),
('KN', 'Saint Kitts and Nevis'),
('KR', 'Korea, Republic of'),
('KW', 'Kuwait'),
('KY', 'Cayman Islands'),
('KZ', 'Kazakhstan'),
('LA', 'Lao People''s Democratic Republic'),
('LB', 'Lebanon'),
('LC', 'Saint Lucia'),
('LI', 'Liechtenstein'),
('LK', 'Sri Lanka'),
('LR', 'Liberia'),
('LS', 'Lesotho'),
('LT', 'Lithuania'),
('LU', 'Luxembourg'),
('LV', 'Latvia'),
('LY', 'Libyan Arab Jamahiriya'),
('MA', 'Morocco'),
('MC', 'Monaco'),
('MD', 'Moldova, Republic of'),
('MG', 'Madagascar'),
('MH', 'Marshall Islands'),
('MK', 'Macedonia, the Former Yugoslav Republic of'),
('ML', 'Mali'),
('MM', 'Myanmar'),
('MN', 'Mongolia'),
('MO', 'Macao'),
('MP', 'Northern Mariana Islands'),
('MQ', 'Martinique'),
('MR', 'Mauritania'),
('MS', 'Montserrat'),
('MT', 'Malta'),
('MU', 'Mauritius'),
('MV', 'Maldives'),
('MW', 'Malawi'),
('MX', 'Mexico'),
('MY', 'Malaysia'),
('MZ', 'Mozambique'),
('NA', 'Namibia'),
('NC', 'New Caledonia'),
('NE', 'Niger'),
('NF', 'Norfolk Island'),
('NG', 'Nigeria'),
('NI', 'Nicaragua'),
('NL', 'Netherlands'),
('NO', 'Norway'),
('NP', 'Nepal'),
('NR', 'Nauru'),
('NU', 'Niue'),
('NZ', 'New Zealand'),
('OF', 'Korea, Democratic People''s Republic of'),
('OM', 'Oman'),
('PA', 'Panama'),
('PE', 'Peru'),
('PF', 'French Polynesia'),
('PG', 'Papua New Guinea'),
('PH', 'Philippines'),
('PK', 'Pakistan'),
('PL', 'Poland'),
('PM', 'Saint Pierre and Miquelon'),
('PN', 'Pitcairn'),
('PR', 'Puerto Rico'),
('PS', 'Palestinian Territory, Occupied'),
('PT', 'Portugal'),
('PW', 'Palau'),
('PY', 'Paraguay'),
('QA', 'Qatar'),
('RE', 'Reunion'),
('RO', 'Romania'),
('RU', 'Russian Federation'),
('RW', 'Rwanda'),
('SA', 'Saudi Arabia'),
('SB', 'Solomon Islands'),
('SC', 'Seychelles'),
('SD', 'Sudan'),
('SE', 'Sweden'),
('SG', 'Singapore'),
('SH', 'Saint Helena'),
('SI', 'Slovenia'),
('SJ', 'Svalbard and Jan Mayen'),
('SK', 'Slovakia'),
('SL', 'Sierra Leone'),
('SM', 'San Marino'),
('SN', 'Senegal'),
('SO', 'Somalia'),
('SR', 'Suriname'),
('ST', 'Sao Tome and Principe'),
('SV', 'El Salvador'),
('SY', 'Syrian Arab Republic'),
('SZ', 'Swaziland'),
('TC', 'Turks and Caicos Islands'),
('TD', 'Chad'),
('TF', 'French Southern Territories'),
('TG', 'Togo'),
('TH', 'Thailand'),
('TJ', 'Tajikistan'),
('TK', 'Tokelau'),
('TL', 'Timor-Leste'),
('TM', 'Turkmenistan'),
('TN', 'Tunisia'),
('TO', 'Tonga'),
('TR', 'Turkey'),
('TT', 'Trinidad and Tobago'),
('TV', 'Tuvalu'),
('TW', 'Taiwan, Province of China'),
('TZ', 'Tanzania, United Republic of'),
('UA', 'Ukraine'),
('UG', 'Uganda'),
('UM', 'United States Minor Outlying Islands'),
('US', 'United States'),
('UY', 'Uruguay'),
('UZ', 'Uzbekistan'),
('VA', 'Holy See (Vatican City State)'),
('VC', 'Saint Vincent and the Grenadines'),
('VE', 'Venezuela'),
('VG', 'Virgin Islands, British'),
('VI', 'Virgin Islands, U.s.'),
('VN', 'Viet Nam'),
('VU', 'Vanuatu'),
('WF', 'Wallis and Futuna'),
('WS', 'Samoa'),
('YE', 'Yemen'),
('YT', 'Mayotte'),
('ZA', 'South Africa'),
('ZM', 'Zambia'),
('ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `real_estate`
--

CREATE TABLE IF NOT EXISTS `real_estate` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `address_streetnr` varchar(255) NOT NULL,
  `address_city` varchar(255) NOT NULL,
  `address_postcode` varchar(225) NOT NULL,
  `countries_code` varchar(2) NOT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `ki` double DEFAULT NULL,
  `visible` enum('Y','N') DEFAULT 'Y',
  `companies_ID` int(11) NOT NULL,
  `description` text,
  `popularity` int(11) DEFAULT '0',
  `categories_ID` int(11) NOT NULL,
  `area` int(11) DEFAULT NULL,
  `type` enum('S','R') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`ID`),
  KEY `fk_real_estate_countries1_idx` (`countries_code`),
  KEY `fk_real_estate_companies1_idx` (`companies_ID`),
  KEY `fk_real_estate_category1_idx` (`categories_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Gegevens worden uitgevoerd voor tabel `real_estate`
--

INSERT INTO `real_estate` (`ID`, `price`, `address_streetnr`, `address_city`, `address_postcode`, `countries_code`, `bedrooms`, `ki`, `visible`, `companies_ID`, `description`, `popularity`, `categories_ID`, `area`, `type`) VALUES
(2, 180000, 'ChaussÃ©e d''Anvers 479', 'Brussels', '1000', 'BE', 2, 150, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Immediately</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">District or place name : Quartier Nord</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1900</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Width of fa&ccedil;ade to street : 5,80 m</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 3</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cable TV</p>\r\n<p style="margin: 0px; padding: 0px;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Description of rooms</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">&nbsp;</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Living room : 25 m&sup2;</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Kitchen : 25 m&sup2;</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Kitchen : Hyper-equipped</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Bedroom 1 : 25 m&sup2;</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Bedroom 2 : 16 m&sup2;</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Bathrooms : 1</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Shower rooms : 1</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Toilets : 2</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Attic : yes</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Attic accessible with fixed stairs</span></span></p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">Cellar : Yes</span></span></p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>', 0, 1, 25, 'S'),
(3, 500000, 'Greepstraat 9', 'Brussels', '1000', 'BE', 2, 200, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Upon exchange of deeds</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">District or place name : centre</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Width of fa&ccedil;ade to street : 6 m</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Good condition</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 4</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. dwellings : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Rooms:</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bedroom 1 : 12 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bedroom 2 : 12 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>', 0, 1, 125, 'S'),
(4, 750, 'Kortrijkstraat 50', 'Brussels', '1000', 'BE', 1, 0, 'Y', 1, '<p>Financial details</p>\r\n<p>&nbsp;</p>\r\n<p>Requested monthly rental 750 &euro;</p>\r\n<p>Monthly charges : 55 &euro;</p>\r\n<p>&nbsp;</p>\r\n<p>Description of rooms</p>\r\n<p>&nbsp;</p>\r\n<p>Kitchen : Installed</p>\r\n<p>Shower rooms : 1</p>', 0, 1, 50, 'R'),
(7, 1800, 'Rue Schmitz 41', 'Brussels', '1000', 'BE', 2, 0, 'N', 1, '<p>Requested monthly rental 1.800 &euro;</p>\r\n<p>&nbsp;</p>\r\n<p>Available as of : 15/03/2012</p>\r\n<p>15/03/2012</p>\r\n<p>Urban</p>\r\n<p>No. floors : 2</p>\r\n<p>&nbsp;</p>\r\n<p>Living room : 19 m&sup2;</p>\r\n<p>Study : Yes</p>\r\n<p>Shower rooms : 2</p>', 0, 1, 65, 'R'),
(8, 240000, 'Segherslaan 12', 'Brussels', '1000', 'BE', 0, 500, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available floor area : 140 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Study : 140 m&sup2;</p>', 0, 5, 140, 'S'),
(9, 25000, 'Emile Jacqmainlaan 137', 'Brussels', '1000', 'BE', 0, 0, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Immediately</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Name of the residence / building : Jacqmain Residence</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">District or place name : Alhambra</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 2007</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Covered parking spaces : 1</p>', 0, 7, 4, 'S'),
(10, 112000, 'Hamerstraat 179', 'Gent', '9000', 'BE', 2, 195, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be done up</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cable TV</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Connection to sewer network</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : Yes</p>', 0, 1, 23, 'S'),
(11, 115000, 'Geitstraat 118', 'Gent', '9000', 'BE', 2, 265, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Upon exchange of deeds</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be renovated</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. dwellings : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Connection to sewer network</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Semi-equipped</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>', 0, 1, 24, 'S'),
(12, 115000, 'Geitstraat 12', 'Gent', '9000', 'BE', 1, 173, 'Y', 1, '<p>Urban&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Dining room : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cellar : Yes</p>', 0, 1, 32, 'S'),
(13, 116500, 'Ijskelderstraat 121', 'Gent', '9000', 'BE', 2, NULL, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1930</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Width of fa&ccedil;ade to street : 4 m</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be done up</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : 13 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : 6 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bedroom 1 : 17 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bedroom 2 : 17 m&sup2;</p>', 0, 1, 89, 'S'),
(14, 125000, 'Kwakkelstraat 27', 'Gent', '9000', 'BE', 2, NULL, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1895</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Semi-equipped</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>', 0, 1, 40, 'S'),
(15, 125000, 'Lobeliastraat 77', 'Gent', '9000', 'BE', 1, 146, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Bij akte / &agrave; l''acte</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1965</p>', 0, 1, 22, 'S'),
(16, 129000, 'Schommelstraat 6', 'Gent', '9000', 'BE', 1, 163, 'Y', 1, NULL, 0, 1, 25, 'S'),
(17, 129000, 'Muidepoort 49', 'Gent', '9000', 'BE', 2, 436, 'Y', 1, '<p><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif; font-size: 12px;">Living room : Yes</span></p>\r\n<p><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">House does have a new roof.</span></span></p>', 0, 1, 33, 'S'),
(18, 130000, 'Vlotstraat 67', 'Gent', '9000', 'BE', 2, 228, 'N', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1930</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Width of fa&ccedil;ade to street : 5 m</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be done up</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cable TV</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Installed</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cellar : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px;"><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif;"><span style="font-size: 12px;">EPC: 670 kWh/m&sup2;</span></span></p>', 0, 1, 30, 'S'),
(19, 130000, 'Schommelstraat 15', 'Gent', '9000', 'BE', 3, NULL, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Residential</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1950</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Good condition</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Number of faces : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : 16 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : 10 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Semi-equipped</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>', 0, 1, 45, 'S'),
(20, 135000, 'Kwakkelstraat 13', 'Gent', '9000', 'BE', 2, 171, 'Y', 1, '<p>Perfect for students.</p>', 0, 1, 35, 'S'),
(21, 140000, 'Myosotisstraat 23', 'Gent', '9000', 'BE', 3, NULL, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be done up</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : Yes</p>', 0, 1, 69, 'S'),
(22, 230, 'Karel Van Hulthemstraat 41', 'Gent', '9000', 'BE', 1, 0, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Requested&nbsp;<strong style="margin: 0px; padding: 0px;">monthly rental</strong>&nbsp;230 &euro;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Monthly charges : 40 &euro;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Immediately</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">District or place name : studenten</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Furnished</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1900</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Just renovated</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 5</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Intercom</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Shower rooms : 1</p>', 0, 2, NULL, 'R'),
(23, 320, 'Frans Ackermanstraat 22', 'Gent', '9000', 'BE', 1, 0, 'Y', 1, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Requested&nbsp;<strong style="margin: 0px; padding: 0px;">monthly rental</strong>&nbsp;320 &euro;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Monthly charges : 45 &euro;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Annual rent&nbsp;gross : 3.840 &euro;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : 01/09/2013<br style="margin: 0px; padding: 0px;" />2013-09-01</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Name of the residence / building : Helios</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1994</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Good condition</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Floor of property : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Secure access/alarm</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Installed</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Lift</p>', 0, 2, 20, 'R'),
(24, 340, 'Voskenslaan 65', 'Gent', '9000', 'BE', 1, NULL, 'Y', 1, '<p><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif; font-size: 12px;">Requested&nbsp;</span><strong style="margin: 0px; padding: 0px; color: #4d4d4d; font-family: Arial, Helvetica, sans-serif; font-size: 12px;">monthly rental</strong><span style="color: #4d4d4d; font-family: Arial, Helvetica, sans-serif; font-size: 12px;">&nbsp;340 &euro;</span></p>\r\n<p>&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Available as of : Per datum / Fix&eacute;e le</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1972</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Good condition</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 3</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Floor of property : 2</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Cable TV</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Study : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : Installed</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Bathrooms : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>', 0, 2, 16, 'R'),
(25, 79000, 'Doolhofstraat 31', 'Aalst', '9300', 'BE', 2, 228, 'Y', 2, '<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Urban</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Year of construction : 1935</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Width of fa&ccedil;ade to street : 4 m</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">To be done up</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">No. floors : 1</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Connection to sewer network</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">&nbsp;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Living room : 12 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Dining room : Yes</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Kitchen : 8 m&sup2;</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Utility room</p>\r\n<p style="margin: 0px; padding: 0px; color: #4d4d4d; font-size: 12px; font-family: Arial, Helvetica, sans-serif;">Toilets : 1</p>', 0, 1, 10, 'S');

--
-- Beperkingen voor gedumpte tabellen
--

--
-- Beperkingen voor tabel `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `fk_companies_countries` FOREIGN KEY (`countries_code`) REFERENCES `countries` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Beperkingen voor tabel `real_estate`
--
ALTER TABLE `real_estate`
  ADD CONSTRAINT `fk_real_estate_category1` FOREIGN KEY (`categories_ID`) REFERENCES `categories` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_real_estate_companies1` FOREIGN KEY (`companies_ID`) REFERENCES `companies` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_real_estate_countries1` FOREIGN KEY (`countries_code`) REFERENCES `countries` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
