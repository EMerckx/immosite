<?php

/**
 * Config - Debug
 * ----------------------------------------------------------------
 */

	// Is debug enabled? If so, errors are shown on screen
	define('DEBUG', true);


/**
 * Config - Database Config
 * ----------------------------------------------------------------
 */

	//Database Server Host
	define ('DB_HOST', 'localhost');

	// Database Server Username
	define ('DB_USER', 'root');

	// Database Server Password
	define ('DB_PASS', 'Azerty123');

	// Database Name
	define ('DB_NAME', 'immosite');

	// Database Error Log
//	define ('ERROR_LOG', '../errorlog.txt');


/**
 * Config - Encryption
 * ----------------------------------------------------------------
 */

	// Salt to use when encrypting passwords
	define('PASSWORD_SALT', '&JakLu|IlY]8YT[^6W>H*¨%£qsdf8"#51gç{_&_@€kdhg^$ù`ù^$m,;:j)');

/**
 * Config - Encryption
 * ----------------------------------------------------------------
 */

    //for emails
    //'swiftmailer.options' -> array('host' => 'smtp.kahosl.be', 'port' => 25);

// EOF