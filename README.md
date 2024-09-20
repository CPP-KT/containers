# CPP-KT/containers

В этом репозитории хранятся конфигурации контейнеров, используемых в GitHub Actions для сборки и запуска тестов.

## Установка Docker

### Linux

Следуйте инструкциям по установке для вашего дистрибутива: https://docs.docker.com/engine/install/#server.

Например, для Ubuntu:

```shell
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce
```

Чтобы Docker можно было использовать без `sudo`, нужно создать соответствующую группу и добавить в неё своего пользователя:
```shell
sudo groupadd docker
sudo usermod -aG docker $USER
```

После этого, вероятно, придётся перезапустить пользовательскую сессию.

### macOS

Установите [Docker Desktop](https://docs.docker.com/desktop/install/mac-install/) с официального сайта.

Или, если у вас установлен пакетный менеджер [homebrew](https://brew.sh/), можете сделать это более ёмко через терминал:

```shell
brew install --cask docker
open -a docker
```

Если вам не нравится всплывающий при запуске из терминала `dashboard`, вы можете отключить такое поведение, сняв чекбокс в `"Preferences" -> "General" -> "Open Docker Dashboard at startup"`.

### Windows

Установите [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/).

> [!NOTE]
> Если у вас Windows, вы можете помочь дополнить этот раздел.

## Установка и обновление образов

Мы предлагаем отдельные образы Ubuntu для gcc и clang.
Если вы хотите проверять своё решение обоими компиляторами, понадобится установить оба образа.

Пример установки образов с `gcc 14` и `clang 19` (в зависимости от задания, версии, используемые в CI, могут отличаться):
```shell
docker pull ghcr.io/cpp-kt/ubuntu:gcc-14
docker pull ghcr.io/cpp-kt/ubuntu:clang-19
```

Для обновления образов нужно снова сделать `docker pull`.
При этом у вас в системе одновременно будут доступны и старые, и новые образы (однако тег будет указывать именно на новый).
Чтобы старые образы не занимали лишнее место на диске, можно их почистить с помощью `docker image prune` (удалит все образы без тега).

## Интеграция с CLion

Подробнее про интеграцию с CLion можно почитать [тут](https://www.jetbrains.com/help/clion/clion-toolchains-in-docker.html#build-run-debug-docker).

- Заходим в Settings -> Build, Execution,... -> Toolchains
- Создаём новый тулчейн типа "Docker"
- CLion должен сам задетектить Docker server и установленные образы, выбираем нужный
- В настройках созданного тулчейна в поле "CMake" выберите "Custom CMake executable" и впишите туда `cmake`
- В поле "Build Tool" впишите `ninja`
- Остальные поля можно оставить без изменения

Эти действия достаточно проделать один раз, т.к. тулчейны не привязаны к текущему проекту.

Чтобы использовать созданный тулчейн, сделайте его тулчейном по умолчанию (подняв в самый верх) или укажите его в поле "Toolchain" в CMake profile.

При любых непонятных ошибках первым делом попробуйте ресетнуть CMake проект: Tools -> CMake -> Reset Cache and Reload Project. Если не помогает, приходите в чат.

## Ручной запуск

Можно запустить шелл в контейнере и делать нужные вам действия прямо из него.
Наверняка при этом вы хотите шарить какую-нибудь директорию вашей системы с файловой системой контейнера.
Сделать это можно следующим образом (заменив пути и имя образа на нужные вам):

```shell
docker run -it --rm \
  -v <path/to/local/directory>:/<path/to/container/directory> \
  -w <path/to/container/directory> \
  -u $(id -u):$(id -g) \
  <image_name>
```

Например, находясь в корне проекта:
```shell
docker run -it --rm \
  -v .:/src -w /src \
  -u $(id -u):$(id -g) \
  ghcr.io/cpp-kt/ubuntu:gcc-14
```

Внутри контейнера для сборки и запуска можно использовать скрипты из директории `ci-extra`:
```shell
ci-extra/build.sh Release
ci-extra/test.sh Release
```

Также можно запускать отдельные команды через докер, не заходя в него:
```shell
docker run -t --rm -v .:/src -w /src -u $(id -u):$(id -g) ghcr.io/cpp-kt/ubuntu:gcc-14 \
  ci-extra/build.sh Release
docker run -t --rm -v .:/src -w /src -u $(id -u):$(id -g) ghcr.io/cpp-kt/ubuntu:gcc-14 \
  ci-extra/test.sh Release
```
