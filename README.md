# elixir-setup-macos

## Introducción

Paso a paso para preparar un ambiente de desarrollo en macos para elixir.

## Instalación asdf

```shell
$ brew install coreutilsgit curl unzip
```

```shell
$ brew install asdf
```

Agregar `asdf` al arranque del shell:

```shell
$ vim $HOME/.zshrc
```

Al final agregamos:

```
# load asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
```

Recargamos el shell:

```shell
$ source $HOME/.zshrc
```

Verificamos la instalación de `asdf`:

```shell
$ asdf --version
v0.10.2
```

Agregamos los plugins para `erlang` y `elixir`:

```shell
$ asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
$ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

Instalamos los plugins para `erlang` y lo configuramos para el proyecto local:

```shell
$ asdf install erlang 23.3
$ asdf local erlang 23.3
```

Instalamos los plugins para `elixir` y lo configuramos para el proyecto local:

```shell
$ asdf install elixir 1.12-otp-23
$ asdf local elixir 1.12-otp-23
```

Verificamos la instalación de elixir:

```shell
$ elixir --version
Erlang/OTP 23 [erts-11.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Elixir 1.12.3 (compiled with Erlang/OTP 23)
```

## Creando proyecto phoenix

Creamos un directorio de trabajo para el nuevo proyecto:

```shell
$ mkdir $HOME/elixir-dev
$ cd $HOME/elixir-dev
```

Configuramos la versión de `erlang` para el proyecto local:

```shell
$ asdf local erlang 23.3
```

Configuramos la versión de `elixir` para el proyecto local:

```shell
$ asdf local elixir 1.12-otp-23
```

Esto nos crea el archivo:

```shell
$ cat .tool-versions
erlang 23.3
elixir 1.12-otp-23
```

Ahora instalamos `hex`:

```shell
$ mix local.hex
Are you sure you want to install "https://repo.hex.pm/installs/1.12.0/hex-1.0.1.ez"? [Yn] y
* creating .asdf/installs/elixir/1.12-otp-23/.mix/archives/hex-1.0.1
```

También instalamos `rebar`:

```shell
$ mix local.rebar
* creating .asdf/installs/elixir/1.12-otp-23/.mix/rebar
* creating .asdf/installs/elixir/1.12-otp-23/.mix/rebar3
```

Instalamos el archive installer de phoenix, el cual es usado para generar la estructura base del proyecto:

```shell
$ mix archive.install hex phx_new
Resolving Hex dependencies...
Dependency resolution completed:
New:
  phx_new 1.6.10
* Getting phx_new (Hex package)
All dependencies are up to date
Compiling 11 files (.ex)
Generated phx_new app
Generated archive "phx_new-1.6.10.ez" with MIX_ENV=prod
```

```shell
$ mix phx.new src --app hello --no-ecto
* creating src/config/config.exs
* creating src/config/dev.exs
* creating src/config/prod.exs
* creating src/config/runtime.exs
* creating src/config/test.exs
* creating src/lib/hello/application.ex
* creating src/lib/hello.ex
* creating src/lib/hello_web/views/error_helpers.ex
* creating src/lib/hello_web/views/error_view.ex
* creating src/lib/hello_web/endpoint.ex
* creating src/lib/hello_web/router.ex
* creating src/lib/hello_web/telemetry.ex
* creating src/lib/hello_web.ex
* creating src/mix.exs
* creating src/README.md
* creating src/.formatter.exs
* creating src/.gitignore
* creating src/test/support/conn_case.ex
* creating src/test/test_helper.exs
* creating src/test/hello_web/views/error_view_test.exs
* creating src/lib/hello_web/controllers/page_controller.ex
* creating src/lib/hello_web/views/page_view.ex
* creating src/test/hello_web/controllers/page_controller_test.exs
* creating src/test/hello_web/views/page_view_test.exs
* creating src/assets/vendor/topbar.js
* creating src/lib/hello_web/templates/layout/root.html.heex
* creating src/lib/hello_web/templates/layout/app.html.heex
* creating src/lib/hello_web/templates/layout/live.html.heex
* creating src/lib/hello_web/views/layout_view.ex
* creating src/lib/hello_web/templates/page/index.html.heex
* creating src/test/hello_web/views/layout_view_test.exs
* creating src/lib/hello/mailer.ex
* creating src/lib/hello_web/gettext.ex
* creating src/priv/gettext/en/LC_MESSAGES/errors.po
* creating src/priv/gettext/errors.pot
* creating src/assets/css/phoenix.css
* creating src/assets/css/app.css
* creating src/assets/js/app.js
* creating src/priv/static/robots.txt
* creating src/priv/static/images/phoenix.png
* creating src/priv/static/favicon.ico

Fetch and install dependencies? [Yn] y
* running mix deps.get
* running mix deps.compile

We are almost there! The following steps are missing:

    $ cd src

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server

```

Y listo, ahora el código base se encuentra en el directorio `src`, echemos un vistazo:

Corremos el servidor phoenix en local:

```shell
$ mix phx.server
Compiling 13 files (.ex)
Generated hello app
[info] Running HelloWeb.Endpoint with cowboy 2.9.0 at 127.0.0.1:4000 (http)
[debug] Downloading esbuild from https://registry.npmjs.org/esbuild-darwin-arm64/-/esbuild-darwin-arm64-0.14.29.tgz
[info] Access HelloWeb.Endpoint at http://localhost:4000
[watch] build finished, watching for changes...
```

Ahora puedes apuntar tu navegador a `https://localhost:4000`.

## Referencias

Leer las siguientes referencias adicionales para complementar la guía:

 * [asdf](https://asdf-vm.com/)
 * [Install Elixir using asdf](https://thinkingelixir.com/install-elixir-using-asdf/)
 * [Phoenix Framework](https://www.phoenixframework.org/)
 * [Phoenix Up and running](https://hexdocs.pm/phoenix/up_and_running.html)
