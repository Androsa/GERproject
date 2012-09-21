<?php
/**
 * sqspell_config.php -- SquirrelSpell Configuration file.
 *
 * Copyright (c) 1999-2012 The SquirrelMail Project Team
 * Licensed under the GNU GPL. For full terms see the file COPYING.
 *
 * @version $Id: sqspell_config.php 14248 2012-01-02 00:18:17Z pdontthink $
 * @package plugins
 * @subpackage squirrelspell
 */

require_once(SM_PATH . 'functions/prefs.php');

/* Just for poor wretched souls with E_ALL. :) */
global $data_dir;

sqgetGlobalVar('username', $username, SQ_SESSION);

/**
 * Example:
 *
 * $SQSPELL_APP = array( 'american (American English)' => 'ispell -a',
 *                     'spanish (Spanish)' => 'ispell -d spanish -a' );
 * You can replace ispell with aspell keeping the same commandline:
 * $SQSPELL_APP = array( 'american (American English)' => 'aspell -a',
 *                     'spanish (Spanish)' => 'aspell -d spanish -a' );
 */

# Debian: if dictionaries-common >= 2.81.1 is available, detect the
# installed dictionaries automatically, else use the list below.
if ( ! @include('/var/cache/dictionaries-common/sqspell.php') ) {
    $SQSPELL_APP = array('american (American English)' => 'ispell -a',
                 'spanish (Spanish)' => 'ispell -d spanish -a');
}

# Debian: if dictionaries-common >= 2.50 is available, detect the
# default dictionary automatically.
if ( is_readable ( '/etc/dictionaries-common/ispell-default' ) ) {
    $SQSPELL_APP_DEFAULT = file_get_contents ( '/etc/dictionaries-common/ispell-default' );
} else {
    $SQSPELL_APP_DEFAULT = 'american (American English)';
}

$SQSPELL_WORDS_FILE = 
   getHashedFile($username, $data_dir, "$username.words");

$SQSPELL_EREG = 'ereg';

