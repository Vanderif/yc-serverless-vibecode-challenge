# Описание

Данная инструкция описывает шаги, необходимые для настройки окружения для выполнения задач Vibe Code Challange на Yandex Cloud Scale 2025.

# Предварительные настройки

Кроме подготовки непосредственно рабочих станций, с которых пользователи будут выполнять задания, необходимо предварительно настроить облачные окружения, где будут создаваться ресурсы. Эти настройки включают в себя:
1. Облако Yandex Cloud. Облако может быть как общим на все задания челенджа, так и отдельными для каждого задания. При необходимости далее ссылаемся на это облако как 'cloud-id'.
2. Пользователя или пользователей Yandex Cloud. Тип учетной записи не важен, но в данной инструкции предполагается работа через федеративного пользователя. Предполагается, что для каждого задания создан отдельный пользователь. Далее из описания каждого задания ссылаемся на этого пользователя как 'user-account-id'.
3. Каталог в облаке для выполнения заданий. Предполагается, что для каждого задания создан отдельный каталог для изоляции настроек и ресурсов. Далее ссылаемся на этот каталог как 'folder-id'.

# Общая настройка окружения

1. Установка VS Code (тут и далее предполагается, что установка происзводится на MacOS). Полный гайд: https://code.visualstudio.com/docs/setup/mac.

    1.1. Скачать https://go.microsoft.com/fwlink/?LinkID=534106

    1.2. Распаковать архив.

    1.3. Установить распакованное приложение стандартным образом.

2. Установка плагина Roo Code для VSCode. Полный гайд: https://github.com/RooCodeInc/Roo-Code-Docs/blob/main/docs/getting-started/installing.mdx.

    2.1. Открыть VS Code.

    2.2. Открыть VS Code Marketplace.

    2.3. Найти и установить Roo Code от RooVeterinaryInc.

3. Настройка плагина Roo Code. Полный гайд: https://yandex.cloud/ru/docs/foundation-models/tutorials/qwen-vsc-integration.

    3.1. Создать сервисный аккаунт в каталоге 'folder-id'.

    3.2. Добавить созданному аккаунту роль 'ai.languageModels.user' на каталог.

    3.3. Перейти в IAM и зайти на созданный SA.

    3.4. Создать для SA API ключ с областью действия 'yc.ai.languageModels.execute'. Сохранить значения идентификатора и секретного ключа.

    3.5. Перейти в настройки Roo Code.

    3.6. В поле Base URL указать 'https://llm.api.cloud.yandex.net/v1'.

    3.7. В поле API-key указать значение секретного ключа, созданного на шаге 3.4.

    3.8. В поле Model указать 'gpt://folder-id/qwen3-235b-a22b-fp8/latest'

4. Установка и настройка YC CLI. Полный гайд: https://yandex.cloud/ru/docs/cli/operations/install-cli.

    4.1. Выполнить
    ```bash
    curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
    ```

    4.2. Перезапустить командную оболочку.

    4.3. Выполнить
    ```bash
    yc init --federation-id=<federation-id>
    ```

    Создать новый профиль.

    4.4. Вернуться в интерфейс командной строки. Выбрать в списке 'cloud-id'. Выбрать в нем 'folder-id'. Выбрать дефолтную зону доступности, например, 'ru-central1-d'.

# Специфичные настройки окружения

## Настройки для задания Deploy Cloud Function

1. Создать Service Account 'sles-vibecoding' для работы с Object Storage.

2. Создать Object Storage бакет с названием 'sles-vibecoding' и в его ACL дать доступ для SA, созданному на предыдущем шаге, на READ_WRITE.

3. Создать Service Account для запуска Cloud Functions. Это может быть тот же SA, что и для работы с Object Storage. Выдать ему роль 'functions.functionInvoker' на уровне каталога.

## Специфичные настройки для задания NextJS

1. Установить [Docker](https://www.docker.com).
2. Установить [NodeJS](https://nodejs.org).
3. Установить [Typescript](https://www.typescriptlang.org).
4. Установить [Terraform](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart#install-terraform).

## Специфичные настройки для задания IOT Core

Отсутствуют.
