# AskMe!

## Описание
AskMe - сайт, на котором можно регистрироваться, задавать вопросы другим людям и отвечать на свои!
Приложение является клоном сайта [Ask.fm](https://ask.fm/).


Последнюю актуальную версию приложения можно посмотреть [здесь](https://stormy-beyond-63141.herokuapp.com/).

**Использованные технологии**:
- [Recaptcha](https://developers.google.com/recaptcha/docs/display) - для защиты от спама
- [Gravtastic](https://github.com/chrislloyd/gravtastic) - для аватарок пользователей на основе [Gravatar API](https://ru.gravatar.com/)

Требования:

```
Ruby 3.0.2
Rails 7.0.3
```

## Использование

Установите необходимые гемы и подготовьте базу данных с помощью следующих команд:

```
bundle install
bundle exec rake db:migrate
```

Для использования Recaptcha нужно прописать Ваши ключи в `credentials.yml.enc`.

Для этого требуется ввести следующие команды:

```
rm -rf config/credentials.yml.enc
EDITOR=<your_prefered_editor> rails credentials:edit 
```

Затем заполнить по образцу:

```
recaptcha:
  site_key: <your_recaptcha_site_key>
  secret_key: <your_recaptcha_secret_key>
```

### Запуск

Для запуска сервера локально введите команду:

```
bundle exec rails s
```

В production окружении приложение настроено на работу с [Heroku](https://dashboard.heroku.com/login).
