# Немного инструкций для внедрения CI

## Static Analyzer script
```sa.sh``` - скрипт, который анализирует выходной файл анализаторов

Пример использования:

`sa.sh phpstan.log 5`

`phpstan.log` - название файла для анализа (файл в raw формате выводится - только строчки с ошибками)

`5` - количество разрешенных ошибок (должно регулироваться в настройках CI)


## Unit-tests coverage script
```pu.sh``` - скрипт, который анализирует результат Unit-тестов и валидирует их в соответвии с CI конфигурацией проекта

Пример использования:

`pu.sh unittest.log 80`

`unittest.log` - название файла для анализа (файл в raw формате выводится - только строчки с ошибками)

`80` - процент не ниже которого должно быть покрытие тестами в проекте (должно регулироваться в настройках CI)

PS: unit - тесты запускать можно командой
`phpdbg -qrr -dmemory_limit=-1 vendor/bin/phpunit --configuration phpunit.xml.dist --coverage-text --colors=never`

## phpstan 
запускать как 

```vendor/bin/phpstan analyse src --level 7 --no-progress --error-format raw > phpstan.log```

А затем в проверки добавить `sa.sh phpstan.log 5`

`level 7` - тоже должно регульроваться в конфигурации CI проекта


## phan 
запускать как 

`./vendor/bin/phan --allow-polyfill-parser -o phan.log`

результат работы будет выведен в файл `phan.log`, в котором будут отображены все найденные ошибки

И в проверки добавить `sa.sh phan.log 5`


## psalm 
запускать как 

`./vendor/bin/psalm --show-info=false --no-progress --report-show-info=false | head -n -6 > psalm.log`

результат работы будет выведен в файл `psalm.log`, в котором будут отображены все найденные ошибки

И в проверки добавить `sa.sh psalm.log 5`




