# Домашнее задание "Инструменты Git" - `Прыкин Сергей`

### Задание 1 

Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.  

Полный хеш: aefead2207ef7e2aa5dc81a34aedf0cad4c32545  

Комментарий: Update CHANGELOG.md  

Команда для выполенния git show aefea --pretty=format:'%H %s' -q  

![1](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/1.png)

---

### Задание 2 

Ответьте на вопросы.  

Какому тегу соответствует коммит 85024d3?  
Тег: v0.12.23  
Команда: git show 85024d3 --oneline -q   
![2](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/1.png)


Сколько родителей у коммита b8d720? Напишите их хеши.  
Количество родителей: 2  
Хеши родителей:  
56cd7859e  
9ea88f22f  
![3](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/3.png)

Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24.  
33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24  
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links  
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md  
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable  
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location  
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md  
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows  
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md  
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md  
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release  
![4](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/4.png)

Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) (вместо троеточия перечислены аргументы).  
Хеш коммита: 8c928e835 (полный: 8c928e83589d90a031f811fae52a81be7153e82f)  
Комментарий: main: Consult local directories as potential mirrors of providers  
![5](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/5.png)
![6](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/6.png)

Найдите все коммиты, в которых была изменена функция globalPluginDirs.  
7c4aeac5f30aed09c5ef3198141b033eea9912be stacks: load credentials from config file on startup (#35952)  
65c4ba736375607b6af6c035972f7f151232b6c6 Remove terraform binary  
125eb51dc40b049b38bf2ed11c32c6f594c8ef96 Remove accidentally-committed binary  
22c121df8631c4499d070329c9aa7f5b291494e1 Bump compatibility version to 1.3.0 for terraform core release (#30988)  
7c7e5d8f0a6a50812e6e4db3016ebfd36fa5eaef Don't show data while input if sensitive  
35a058fb3ddfae9cfee0b3893822c9a95b920f4c main: configure credentials from the CLI config file  
c0b17610965450a89598da491ce9b6b5cbd6393f prevent log output during init  
8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package  
![7](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/7.png)

Кто автор функции synchronizedWriters?  
Автор функции Martin Atkins
![8](https://github.com/snprykin/homework/blob/main/Системы%20управления%20версиями/Инструменты%20Git/screenshots/8.png)




