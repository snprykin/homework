# Домашнее задание"Teamcity" - `Прыкин Сергей`

## Выполнение задания  
### Создал три ВМ в соответствии с заданием:

<img src="screenshots/1.png" width="100%">  

### Агент авторизован

<img src="screenshots/2.png" width="100%">  

### Запуск playbook

<img src="screenshots/3.png" width="100%">  

## Решение - основная часть  
1. Новый проект в teamcity на основе fork.
2. Autodetect конфигурации.
3. Запуск первой сборки master. Сборка прошла успешно:

<img src="screenshots/4.png" width="100%">  

4. Изменены условия сборки: если сборка по ветке master, то должен происходит mvn clean deploy, иначе mvn clean test:

<img src="screenshots/5.png" width="100%">  

5. Для deploy загрузили settings.xml в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus:  

<img src="screenshots/6.png" width="100%">

6. В pom.xml изменили ссылки на репозиторий и nexus:  

<img src="screenshots/7.png" width="100%">

7. Запуск сборки по master, убедимся, что всё прошло успешно и артефакт появился в nexus:  

<img src="screenshots/8.png" width="100%">

8. Мигрировали build configuration в репозиторий:  

<img src="screenshots/9.png" width="100%">
<img src="screenshots/10.png" width="100%">

9. Создал отдельную ветку feature/add_reply в репозитории.  

10. Написал новый метод для класса Welcomer: метод возвращает произвольную реплику, содержащую слово hunter:  

<img src="screenshots/11.png" width="100%">

11. Дополнил тест для нового метода на поиск слова hunter в новой реплике:  

<img src="screenshots/12.png" width="100%">

12. Сделал push всех изменений в новую ветку репозитория.  

13. Убедился, что сборка самостоятельно запустилась, тесты прошли успешно:

<img src="screenshots/13.png" width="100%">

14. Сделал Merge ветки feature/add_reply в master.

<img src="screenshots/14.png" width="100%">

15. Убедитесь, что нет собранного артефакта в сборке по ветке master.  
16. Настройте конфигурацию так, чтобы она собирала .jar в артефакты сборки.  
17. Провел повторную сборку мастера  

<img src="screenshots/15.png" width="100%">

18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.  

<img src="screenshots/16.png" width="100%">

19. В ответе пришлите ссылку на репозиторий.  

https://github.com/snprykin/example-teamcity.git

