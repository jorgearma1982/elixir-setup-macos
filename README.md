# elixir-setup-macos

## Introducción

Como ingenieros de infraestructura cada vez es más común participar en proyectos entrega de software en donde
el desarrollo se basa en el lenguaje de programación `Elixir`, el cual se basa en la máquina virtual de `Erlang`,
es decir, la `BEAM`.

En esta guía mostramos como construir proyectos basados en Elixir y Phoenix. Iremos desde lo más básico que es
instalar las dependencias del sistema para poder crear nuestros proyectos, usaremos el manejador de paquetes
`asdf` para simplificar el manejo de las versiones de `erlang` y `elixir` que vamos a necesitar.

En los ejercicios que realicemos usaremos Elixir `12` con Erlang/OTP `23`.

### Objetivos

El principal interés es que los ingenieros de infraestructura aprendan los principios para construir proyectos
basados en Elixir y que sea más sencillo participar en un proyecto de desarrollo basado en Elixir, al final
esperamos:

* Aprender a instalar Erlang y Elixir en modo binario
* Aprender a crear proyectos basados en Elixir y el framework Phoenix
* Aprender a modificar las configuraciones de un proyecto elixir
* Aprender a hacer liberaciones de proyectos basados en elixir

## Instalación del manejador de paquetes asdf

Instalaremos algunas dependencias de sistema para hacer nuestro trabajo:

``` shell
$ brew install coreutils git curl unzip
```

Ahora si instalamos asdf con brew:

``` shell
$ brew install asdf
```

Agregamos `asdf` al arranque del shell:

``` shell
$ vim $HOME/.zshrc
```

Al final agregamos:

```
# load asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
```

Recargamos el shell:

``` shell
$ source $HOME/.zshrc
```

Verificamos la instalación de `asdf`:

``` shell
$ asdf --version
v0.10.2
```

## Instalando los plugins para erlang y elixir

Agregamos los plugins para `erlang` y `elixir`:

``` shell
$ asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
$ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

Instalamos los plugins para `erlang` en su versión mayor `23` y la versión menor `3`:

``` shell
$ asdf install erlang 23.3
```

Instalamos los plugins para `elixir` en versión mayor `1`, versión menor `12` y compatibilidad con erlang/otp `23`:

```shell
$ asdf install elixir 1.12-otp-23
```

Verificamos la instalación de elixir:

```shell
$ elixir --version
Erlang/OTP 23 [erts-11.2] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Elixir 1.12.3 (compiled with Erlang/OTP 23)
```

Como se puede ver en la salida, nos muestra que la versión de elixir coincide con la versión de OTP 23.

## Creando el proyecto phoenix

Ahora que tenemos todos los requisitos listos en nuestra máquina, creamos un directorio de trabajo
para el nuevo proyecto:

```shell
$ mkdir -p $HOME/code/elixir-dev
$ cd $HOME/code/elixir-dev
```

Ahora, los siguientes comandos se deben realizar dentro del directorio del nuevo proyecto. Configuramos
la versión de `erlang` para el proyecto local:

```shell
$ asdf local erlang 23.3
```

Configuramos la versión de `elixir` para el proyecto local:

```shell
$ asdf local elixir 1.12-otp-23
```

Esto nos crea el archivo `.tool-versions`:

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

Generamos un proyecto phoenix en el directorio `src`, la aplicación del proyecto se llama `hello` y desactivamos
el uso de `ecto` ya que de inicio no usaremos bases de datos:

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

Y listo!!!, ahora el código base se encuentra en el directorio `src`, echemos un vistazo.

Nos cambiamos al directorio `src`:

```shell
$ cd src
```

Corremos el servidor phoenix en local:

```shell
$ cd src
$ mix phx.server
Compiling 13 files (.ex)
Generated hello app
[info] Running HelloWeb.Endpoint with cowboy 2.9.0 at 127.0.0.1:4000 (http)
[debug] Downloading esbuild from https://registry.npmjs.org/esbuild-darwin-arm64/-/esbuild-darwin-arm64-0.14.29.tgz
[info] Access HelloWeb.Endpoint at http://localhost:4000
[watch] build finished, watching for changes...
```

Ahora puedes apuntar tu navegador a `https://localhost:4000`.

Verifica que en la salida estándar del servidor phoenix se registran las peticiones realizadas.

Felicidades acabas de crear tu primer proyecto en elixir.

Si quieres ver un dashboard de la operación de Elixir vea al url: `http://localhost:4000/dashboard/home`.

### Modificando el HTML de la página index

Ahora que tenemos nuestro primer proyecto corriendo, aconsejo dejar ahí el servidor corriendo en primer plano
para estar viendo como llegan las peticiones al servidor web que se levanta en el puerto `4000`.

Editaremos el archivo `lib/hello_web/templates/page/index.html.heex`:

``` shell
$ vim lib/hello_web/templates/page/index.html.heex
```

En la segunda línea vemos el mensaje de bienvenida, cambiamos de `Phoenix`:

```
    <h1><%= gettext "Welcome to %{name}!", name: "Phoenix" %></h1>
```

Por algo así:

```
    <h1><%= gettext "Welcome to %{name}!", name: "My World" %></h1>
```

Veras que en cuanto guardas el archivo, el servidor phoenix detecta el cambio en caliente y refresca la vista.

## Cambiando las configuraciones para tiempo de construcción

Ahora veremos un ejercicio en donde hacemos un poco más dinámica la página del indice de nuestra aplicación,
cambiaremos un mensaje de su forma estática a una forma donde obtiene el valor desde un archivo de configuración
en la aplicación.

Volvemos a modificar la página de indice y agregamos la siguiente línea:

```
<p>Message from: <strong><%= Application.fetch_env!(:hello, :myconfig) %></strong></p>
```

En el archivo de configuración tiempo de construcción agregamos una llave y su valor:

```
config :hello, myconfig: "config!"
```

Guardamos la configuración, terminamos el servidor phoenix y lo volvemos a ejecutar para que reconstruya el
proyecto y verifiquemos si se refleja el cambio, deberíamos ver el mensaje:

```
Message from: config!
```

Ahora definimos la llave en el archivo de configuración de desarrollo `config/dev.exs`:

```
config :hello, myconfig: "dev!"
```

Guardamos la configuración y detenemos el servidor phoenix, después volvemos a ejecutarlo para que se construya
la nueva configuración, deberíamos ver el mensaje:

```
Message from: dev!
```

Como podemos ver, las configuraciones y sus valores para construir el proyecto se pueden definir en el archivo
`config/config.exs`, esto aplica de forma general, este archivo es leído antes de que compilamos nuestra aplicación
, incluso antes de cargar nuestras dependencias, esto ayuda a definir como vamos a compilar el proyecto.

Si se quiere definir un parámetro especifico para el ambiente de desarrollo se debe definir en `config/dev.exs`.

## Cambiando las configuraciones para tiempo de ejecución

TODO.

## Haciendo liberaciones

TODO.

## Referencias

Leer las siguientes referencias adicionales para complementar la guía:

* [Brew - The Missing Package Manager for macOS (or Linux)](https://brew.sh/)
* [asdf - Manage multiple runtime versions with a single CLI tool](https://asdf-vm.com/)
* [Install Elixir using asdf](https://thinkingelixir.com/install-elixir-using-asdf/)
* [Phoenix Framework](https://www.phoenixframework.org/)
* [Phoenix Up and running](https://hexdocs.pm/phoenix/up_and_running.html)
* [Elixir - Compatibility and Deprecations](https://hexdocs.pm/elixir/1.12.3/compatibility-and-deprecations.html)
