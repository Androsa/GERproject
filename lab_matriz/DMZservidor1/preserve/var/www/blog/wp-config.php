<?php
/** 
 * As configurações básicas do WordPress.
 *
 * Esse arquivo contém as seguintes configurações: configurações de MySQL, Prefixo de Tabelas,
 * Chaves secretas, Idioma do WordPress, e ABSPATH. Você pode encontrar mais informações
 * visitando {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. Você pode obter as configurações de MySQL de seu servidor de hospedagem.
 *
 * Esse arquivo é usado pelo script ed criação wp-config.php durante a
 * instalação. Você não precisa usar o site, você pode apenas salvar esse arquivo
 * como "wp-config.php" e preencher os valores.
 *
 * @package WordPress
 */

// ** Configurações do MySQL - Você pode pegar essas informações com o serviço de hospedagem ** //
/** O nome do banco de dados do WordPress */
define('DB_NAME', 'blog');

/** Usuário do banco de dados MySQL */
define('DB_USER', 'GERproject');

/** Senha do banco de dados MySQL */
define('DB_PASSWORD', 'GERproject');

/** nome do host do MySQL */
define('DB_HOST', '192.168.2.7');

/** Conjunto de caracteres do banco de dados a ser usado na criação das tabelas. */
define('DB_CHARSET', 'utf8');

/** O tipo de collate do banco de dados. Não altere isso se tiver dúvidas. */
define('DB_COLLATE', '');

/**#@+
 * Chaves únicas de autenticação e salts.
 *
 * Altere cada chave para um frase única!
 * Você pode gerá-las usando o {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * Você pode alterá-las a qualquer momento para desvalidar quaisquer cookies existentes. Isto irá forçar todos os usuários a fazerem login novamente.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'nIJ+JQ(v$4oQ[okytC9ONFNq(g<(7THoz8)-S4/ej,|K$C?+3||NcCbO_&>E%JP(');
define('SECURE_AUTH_KEY',  '[*O]JR]%%!+]_`l-Tvj2+WgF$b#$yUQ[?- #a=Nf>Q3G-Q{2S>m7}tW(8n/,/m;&');
define('LOGGED_IN_KEY',    ';CXo!bLEiq/0o.q~V5Qel,| :>+aom0_+cL4`$b!(k]JP-PjkY@7*3=$2M#``@+0');
define('NONCE_KEY',        're_z=m0w%IMx<A|oXw-r!TKeta3:|3$VHwChmN>swxn<c,rny/]/^k>FuN6om s|');
define('AUTH_SALT',        'C|a1y.x8mrUt2j#lA9*{a:;78edOc51HN.hT3j@Ftfi^$ JRGN:dq7m| ],2U}/+');
define('SECURE_AUTH_SALT', 'KaA~0=fN+w)g_{dKZXUjk_)YEf` l 5O#Q8U-x]>|x=,_J>+QZ*$LNgkGDqm(q=t');
define('LOGGED_IN_SALT',   'vn%wJf-l^Wwnz_t@( [1lNaH#`fu)/#LDj>-`^q}D!+[qVB.C[S#-(6Ea+:&+YG1');
define('NONCE_SALT',       'qh|c=Yn+sd-YESlABmMC+a%uFx[Al_=8(OJVS-!>GX);/[/xv/++2Tp7vQ@kdEs[');

/**#@-*/

/**
 * Prefixo da tabela do banco de dados do WordPress.
 *
 * Você pode ter várias instalações em um único banco de dados se você der para cada um um único
 * prefixo. Somente números, letras e sublinhados!
 */
$table_prefix  = 'wp_';

/**
 * O idioma localizado do WordPress é o inglês por padrão.
 *
 * Altere esta definição para localizar o WordPress. Um arquivo MO correspondente ao
 * idioma escolhido deve ser instalado em wp-content/languages. Por exemplo, instale
 * pt_BR.mo em wp-content/languages e altere WPLANG para 'pt_BR' para habilitar o suporte
 * ao português do Brasil.
 */
define('WPLANG', 'pt_BR');

/**
 * Para desenvolvedores: Modo debugging WordPress.
 *
 * altere isto para true para ativar a exibição de avisos durante o desenvolvimento.
 * é altamente recomendável que os desenvolvedores de plugins e temas usem o WP_DEBUG
 * em seus ambientes de desenvolvimento.
 */
define('WP_DEBUG', false);

/* Isto é tudo, pode parar de editar! :) */

/** Caminho absoluto para o diretório WordPress. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
	
/** Configura as variáveis do WordPress e arquivos inclusos. */
require_once(ABSPATH . 'wp-settings.php');
