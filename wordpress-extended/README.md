## Wordpress Extended

![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)
![](https://img.shields.io/badge/mips64le-lightgrey)

### Description

Build on official wordpress:latest image, added new features.

- Memcached Support
- Redis Support
- Enables adjusting Timezone
- Enables adjusting php settings

### Usage

```bash
docker run \
--name wordpress \
--net=wordpress `#optional`\
-p 80:80 \
-e TZ=Europe/London \
-e WORDPRESS_DB_HOST=EXAMPLE_DB `#optional`\
-e WORDPRESS_DB_USER=EXAMPLE_USER `#optional`\
-e WORDPRESS_DB_PASSWORD=EXAMPLE_PASSWORD `#optional`\
-e WORDPRESS_DB_NAME=EXAMPLE_NAME `#optional`\
-e WORDPRESS_TABLE_PREFIX=EXAMPLE_PREFIX_ `#optional`\
-e WORDPRESS_DEBUG=0 `#optional`\
-e PHP_UPLOAD_MAX_FILESIZE=200M `#optional`\
-e PHP_POST_MAX_SIZE=200M `#optional`\
-e PHP_MAX_EXECUTION_TIME=300 `#optional`\
-e PHP_MEMORY_LIMIT=4096M `#optional`\
-v EXAMPLE_PATH/wordpress:/var/www/html \
-d justinhimself/wordpress-extended:latest
```

### Parameters

| Parameter                                 | Function                                                                                                                                                        |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--net=...`                               | It's recommended to put wordpress and db and maybe redis in one docker network and reference each service using format like `-e WORDPRESS_DB_HOST=db`           |
| `-p 80:80`                                | HTTP port served by apache.                                                                                                                                     |
| `e TZ=...`                                | Timezone. Default will be "Europe/London".                                                                                                                      |
| `-e WORDPRESS_DB_HOST=...`                | Preconfig wordpress db host. Leave blank to configurate it in wordpress setup wizard.                                                                           |
| `-e WORDPRESS_DB_USER=...`                | Preconfig wordpress db user. Leave blank to configurate it in wordpress setup wizard.                                                                           |
| `-e WORDPRESS_DB_PASSWORD=...`            | Preconfig wordpress db password. Leave blank to configurate it in wordpress setup wizard.                                                                       |
| `-e WORDPRESS_DB_NAME=...`                | Preconfig wordpress db name. Leave blank to configurate it in wordpress setup wizard.<br />It's recommended to use something else than "wordpress", "wp"        |
| `-e WORDPRESS_TABLE_PREFIX=...`           | Preconfig wordpress table prefix. Leave blank to configurate it in wordpress setup wizard.<br />It's recommended to use something else than "wordpress*", "wp*" |
| `-e WORDPRESS_DEBUG=0`                    | Set to 1 to enable WP_DEBUG in wp-config.php. Please refer to [debugging-in-wordpress](https://wordpress.org/support/article/debugging-in-wordpress/)           |
| `-e PHP_UPLOAD_MAX_FILESIZE=...`          | Configure PHP upload limit. Default will be 200M.                                                                                                               |
| `-e PHP_POST_MAX_SIZE=...`                | Configure PHP post limit. Default will be 200M.                                                                                                                 |
| `-e PHP_MAX_EXECUTION_TIME=...`           | Configure PHP max execution time. Default will be 300 (s).                                                                                                      |
| `-e PHP_MEMORY_LIMIT=...`                 | Configure PHP memory limit. Default will be 4096M.                                                                                                              |
| `-v EXAMPLE_PATH/wordpress:/var/www/html` | Path to store wordpress files.                                                                                                                                  |

### Additional Environment Variables

Wordpress offical image also offers some variables that I doubt anyone would use.

| Parameter                          | Function                                                                                                                                                                                                                                                                                                                          |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-e WORDPRESS_AUTH_KEY=...`        | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_SECURE_AUTH_KEY=...` | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_LOGGED_IN_KEY=...`   | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_NONCE_KEY=...`       | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_AUTH_SALT=...`       | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_LOGGED_IN_SALT=...`  | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `e WORDPRESS_NONCE_SALT=...`       | default to unique random SHA1s, but only if other environment variable configuration is provided                                                                                                                                                                                                                                  |
| `-e WORDPRESS_CONFIG_EXTRA=...`    | defaults to nothing, non-empty value will be embedded verbatim inside `wp-config.php` -- especially useful for applying extra configuration values this image does not provide by default such as `WP_ALLOW_MULTISITE`; see [docker-library/wordpress#142](https://github.com/docker-library/wordpress/pull/142) for more details |
