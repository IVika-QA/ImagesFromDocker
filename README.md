### Примеры работы с Docker:Покажу,как можно запустить код на Python или Ruby в Docker

## Можно: Выполнить код на Ruby или Python просто выполнив в консоли команду:

```
docker run -it --name <Имя контейнера> --mount type=bind,src=<путь до папки с файлом с Python-кодом>,target=/bind/ python python /bind/counter.py
```
:white_check_mark: Результат: Создается и запускается контейнер,в котором выполняется код python

```
docker run -it --name proba_vika_ruby --mount type=bind,src=<путь до папки с файлом с Ruby-кодом>,target=/bind/ ruby ruby /bind/hello_world.rb
```

:white_check_mark: Результат: Создается и запускается контейнер,в котором выполняется код ruby

## Бывает нужно дополнительно установить библиотеки, чтобы запустить код. Например, я хочу запустить код теста на Python с использованием библиотеки requests.

### Решение 1: Можно из оригинального образа создать контейнер, доставить в него нужные библиотеки,затем создать от этого контейнера свой образ, из своего образа создать контейнер,к которому подключить хранилище, например на хост-машине и запустить кодс тестом на python

1) Скачать оригинальный образ Python

```
docker pull python
```

2) Создать контейнер из образа и войти в него сразу

```
docker run -it --name <имя нового контеейнера> python bash
```

3) Установить в контейнер библиотеку requests,которая нужна для выполнения HTTP-запросов с помощью установила пакетов pip

```
pip install requests
```

4) Смотрим id созданного контейнера

```
docker ps -a
```
5) Создать свой образ из настроенного контейнера

```
docker commit <ID контейнера> <имя нового образа>
```

6) Проверяем, что создался новый образ

```
docker image ls
```

7) Создаем от нового образа контейнер и запускаем в нем файл с кодом на Python - counter.py

```
docker run -it --name <имя нового контейнера> --mount type=bind,src=<путь до папки с файлом с Python-кодом>,target=/bind/ vikaqa_proba_python_requests python /bind/exampe_test_python.py.py

```

:white_check_mark: Результат:
- Создается контейнер на основе оригинального образа с python
- Привязывается локальная директория <путь до папки с файлом с Python-кодом> к директории /bind/ внутри контейнера
- Запускается интерпретатор Python внутри контейнера и выполняет скрипт /bind/exampe_test_python.py.py


### Решение 2: Можно создать свой образ с Ruby,в который положить код с тестом на Ruby. И уже создание контейнера из этого образа запустит выполнение кода на Ruby.

1) Создать директорию
2)Положить в директорию код с тестом на ruby
3)Создать в этой же директории Dockerfile и прописать в него

```
FROM ruby

#Создание папки для файлов с тестами
WORKDIR /app

#Копирование  файла из текущей директории в директорию(папку) app в образе
COPY example_test_ruby.rb .

CMD ruby example_test_ruby.rb

```
:white_check_mark: Результат:
1)Создается новый контейнер, в котором установлена библиотека requests и скопирован сразу файл с кодом
2)Выводится в консоли: Web-страница доступна

## Бывает нужно запустить целую систему контейнеров.
### Например,я хочу запустить код на Ruby СРАЗУ на нескольких версиях Ruby.Мне нужно сделать следующее:

1)Создать папку 1
2)В папке 1 создать папку 2 и папку 3
3)В папку 2 положить код на Ruby + Dockerfile для Ruby версии 3.0.2
```

FROM ruby:3.0.2

WORKDIR /app

COPY hello_world.rb /app/hello_world.rb

CMD ruby hello_world.rb

```
4)В папку 2 положить код на Ruby + Dockerfile для Ruby версии 2.7.4

```

FROM ruby:2.7.4

WORKDIR /app

COPY hello_world.rb /app/hello_world.rb

CMD ruby hello_world.rb

```
4)В папке 1 создать файл docker-compose.yml
```
version: '3'
services:
  service1:
    build:
      context: ./DockerfileForRuby3-0-2
      dockerfile: Dockerfile
  service2:
    build:
      context: ./DockerfileForRuby2-7-4
      dockerfile: Dockerfile

```
5)Перейти в папку 1 и запустить в консоли команду:
```
 docker-compose up
```
:white_check_mark: Результат:
- В консоли два раза выводится слово: Привет, Мир!
