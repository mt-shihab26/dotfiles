return {
    -- Priority order: wp-config.php > .composer.json > index.php > file dir
    root_dir = function(fname)
        local lspconfig = require "lspconfig"

        local wp_root = lspconfig.util.root_pattern "wp-config.php"(fname)
        if wp_root then
            return wp_root
        end

        local composer_root = lspconfig.util.root_pattern "composer.json"(fname)
        if composer_root then
            return composer_root
        end

        local index_root = lspconfig.util.root_pattern "index.php"(fname)
        if index_root then
            return index_root
        end

        return lspconfig.util.path.dirname(fname)
    end,
    settings = {
        intelephense = {
            stubs = {
                -- Core PHP (Essential - Always needed)
                "Core",
                "standard",
                "superglobals",
                "SPL",
                "Reflection",

                -- Data Types & Structures
                "ctype",
                "filter",
                "json",
                "tokenizer",

                -- String & Text Processing
                "mbstring",
                "pcre",
                "gettext",
                "iconv",
                "intl",

                -- Date & Time
                "date",
                "calendar",

                -- File & Directory
                "fileinfo",
                "Phar",

                -- Compression & Archives
                "bz2",
                "zip",
                "zlib",

                -- Networking & Web
                "curl",
                "ftp",
                "openssl",
                "session",
                "soap",

                -- Database
                "PDO",
                "pdo_mysql",
                "pdo_pgsql",
                "pdo_sqlite",
                "pdo_ibm",
                "mysqli",
                "pgsql",
                "sqlite3",
                "oci8",
                "odbc",

                -- XML Processing
                "dom",
                "xml",
                "xmlreader",
                "xmlrpc",
                "xmlwriter",
                "SimpleXML",
                "xsl",

                -- Graphics & Images
                "gd",
                "exif",

                -- Math & Crypto
                "bcmath",
                "gmp",
                "hash",
                "sodium",

                -- System & Process
                "pcntl",
                "posix",
                "shmop",
                "sysvmsg",
                "sysvsem",
                "sysvshm",

                -- Web Server
                "apache",
                "fpm",

                -- Email & Communication
                "imap",
                "snmp",

                -- Text Processing
                "enchant",
                "pspell",
                "tidy",

                -- System Information
                "meta",

                -- Input/Output
                "readline",
                "sockets",

                -- Directory Services
                "ldap",

                -- Database Abstraction
                "dba",

                -- Library Integration
                "libxml",
                "FFI",

                -- Performance & Optimization
                "Zend OPcache",

                -- Legacy/Platform Specific
                "com_dotnet",

                -- WordPress Ecosystem
                "wp-cli",
                "wordpress",
                "elementor",
                "woocommerce",

                -- Additional WordPress Plugin Stubs (uncomment as needed)
                -- "acf-pro",
                -- "genesis",
                -- "polylang",
                -- "jetpack",
                -- "yoast-seo",
                -- "gravity-forms",
                -- "contact-form-7",
                -- "wpml",
                -- "redux-framework",
                -- "advanced-custom-fields",
            },
        },
    },
}
