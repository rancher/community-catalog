### Log Shipper to logstash
* Before choose your filebeat version to launch, please make sure Beats [Support Matrix](https://www.elastic.co/support/matrix#matrix_compatibility)
* Support ship APP log and Nginx log or one of both to Logstash
* Let it default if you only have one log type of both APP log and Ningx log.
* Also you can put all any type log(include app/nginx/other type) to Application Log Path with below pattern.
```bash
eg:
${HOME_PATH}/app/logs/xxx.log
${HOME_PATH}/nginx/logs/xxx.log
${HOME_PATH}/others/logs/xxx.log
```
And set Application Log Path as your `${HOME_PATH}`
