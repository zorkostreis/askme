# AskMe!

## Описание
AskMe - сайт, на котором можно регистрироваться, задавать вопросы другим людям и отвечать на свои!
Приложение является клоном сайта [Ask.fm](https://ask.fm/).

Использованные технологии:
- [Recaptcha](https://developers.google.com/recaptcha/docs/display) - для защиты от спама
- [Gravtastic](https://github.com/chrislloyd/gravtastic) - для аватарок пользователей на основе [Gravatar API](https://ru.gravatar.com/)

Требования:
- Ruby 3.0.2
- Rails 7.0.3
- SQLite для development окружения

## Использование

Установите необходимые гемы и подготовьте базу данных с помощью следующих команд:

```
bundle install
bundle exec rake db:migrate
```
Удалите файл `config/credentials.yml.enc`, затем введите команду:

```
EDITOR="<your_prefered_editor>" rails credentials:edit
```

Добавьте следующие строки и заполните их своими ключами для Recaptcha:

```
recaptcha:
  site_key: <your_recaptcha_site_key>
  secret_key: <your_recaptcha_secret_key>
```

Для запуска сервера локально введите команду:

```
bundle exec rails s
```

## Deploy

В production окружении приложение настроено на работу с [Heroku](https://dashboard.heroku.com/login).

Последнюю актуальную версию приложения можно посмотреть [здесь](https://stormy-beyond-63141.herokuapp.com/).
