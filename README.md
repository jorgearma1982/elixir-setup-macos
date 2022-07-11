# elixir-setup-macos

## Introducción

Como ingenieros de infraestructura cada vez es más común participar en proyectos de entrega de software en donde el desarrollo se basa en el lenguaje de programación `Elixir`, el cual se basa en la máquina virtual de `Erlang`, es decir, la `BEAM`.

En esta guía mostramos cómo construir proyectos basados en Elixir y Phoenix. Iremos desde lo más básico que es instalar las dependencias del sistema para poder crear nuestros proyectos, usaremos el manejador de paquetes `asdf` para simplificar el manejo de las versiones de `erlang` y `elixir` que vamos a necesitar.

En los ejercicios que realicemos usaremos Elixir `12` con Erlang/OTP `23`.

### Objetivos

El principal interés es que los ingenieros de infraestructura aprendan los principios para construir proyectos basados en Elixir y que sea más sencillo participar en un proyecto de desarrollo basado en Elixir, al final esperamos:

* Aprender a instalar Erlang y Elixir en modo binario
* Aprender a crear proyectos basados en Elixir y el framework Phoenix
* Aprender a modificar las configuraciones de un proyecto elixir
* Aprender a hacer liberaciones de proyectos basados en elixir

## Requisitos

Para poder realizar estos ejercicios es necesario tener una instancia del servidor de bases de datos Postgres, en MacOS puede ser instalado a través de la aplicación `Postgres.app`, con esta aplicación podrá crear diferentes instancias de bases de datos en diferentes versiones, lo cual facilita el desarrollo.

Otra forma práctica de levantar un servidor de base de datos es a través de contenedores docker.

Para estos ejercicios usaremos Postgres versión `12`.

## Instalación del manejador de paquetes asdf

Instalaremos algunas dependencias de sistema para hacer nuestro trabajo:

```shell
$ brew install coreutils git curl unzip
```

Ahora si instalamos asdf con brew:

```shell
$ brew install asdf
```

Agregamos `asdf` al arranque del shell:

```shell
$ vim $HOME/.zshrc
```

Al final agregamos:

```shell
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

## Instalando los plugins para erlang y elixir

Agregamos los plugins para `erlang` y `elixir`:

```shell
$ asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
$ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

Instalamos los plugins para `erlang` en su versión mayor `23` y la versión menor `3`:

```shell
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

## Creando el proyecto Phoenix

Ahora que tenemos todos los requisitos listos en nuestra máquina, creamos un directorio de trabajo para el nuevo proyecto:

```shell
$ mkdir -p $HOME/code/elixir-dev
$ cd $HOME/code/elixir-dev
```

Ahora, los siguientes comandos se deben realizar dentro del directorio del nuevo proyecto. Configuramos la versión de `erlang` para el proyecto local:

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

Instalamos el _archive installer_ de Phoenix, el cual es usado para generar la estructura base del proyecto:

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

Generamos un proyecto Phoenix en el directorio `src`, la aplicación del proyecto se llama `hello` y desactivamos el uso de `html` ya que crearemos solo una API:

```shell
$ mix phx.new src --app hello --no-html --no-assets
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
* creating src/lib/hello/repo.ex
* creating src/priv/repo/migrations/.formatter.exs
* creating src/priv/repo/seeds.exs
* creating src/test/support/data_case.ex
* creating src/lib/hello/mailer.ex
* creating src/lib/hello_web/gettext.ex
* creating src/priv/gettext/en/LC_MESSAGES/errors.po
* creating src/priv/gettext/errors.pot

Fetch and install dependencies? [Yn] Y
* running mix deps.get
* running mix deps.compile

We are almost there! The following steps are missing:

    $ cd src

Then configure your database in config/dev.exs and run:

    $ mix ecto.create

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server

```

Y listo!!!, ahora el código base se encuentra en el directorio `src`, echemos un vistazo.

Nos cambiamos al directorio `src` donde realizaremos las tareas:

```shell
$ cd src
```

Ya que nuestra aplicación será una API, debemos desactivar la visualización de errores en modo debug en formato HTML, para esto editamos `config/dev.exs` y en el `Endpoint` de `HelloWeb` cambiamos la llave `debug_errors` a `false`, por ejemplo:

```elixir
config :hello, HelloWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: false,
  secret_key_base: "eyLT2BnWB8FgjAdvqdx6OJ7UFU3ahZQdY8EmJvajhnmUhy2/TCGRjrpoJsvLaJNk",
  watchers: []
```

Ahora editamos el archivo `config/dev.exs` para revisar la configuración a la base de datos, esta es definida en el `Repo`, por ejemplo:

```elixir
# Configure your database
config :hello, Hello.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hello_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

Aquí por default se define la configuración para el repositorio, esto es la base de datos en donde se almacenan los datos de forma persistente y estructurada. Note que cada parámetro de conexión es una llave dedicada.

Ahora si podemos inicializar la base de datos:

```shell
$ mix ecto.create
Compiling 11 files (.ex)
Generated hello app
The database for Hello.Repo has already been created
```

Esto nos crea una base de datos en la instancia Postgres local, nos conectamos a Postgres y con la opción `\l` listamos las bases de datos:

```shell
$ psql "host=localhost dbname=postgres"
postgres=# \l
                                  List of databases
   Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-----------+----------+----------+-------------+-------------+-----------------------
 hello_dev | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 foo.lano  | foo.lano | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
           |          |          |             |             | postgres=CTc/postgres
(5 rows)
postgres=# \c hello_dev
psql (14.3, server 12.11)
You are now connected to database "hello_dev" as user "jmedina".
hello_dev=# \dt
Did not find any relations.
```

Note que en el comando de arriba se listan las bases de datos default: `postgres`, `template0`, `template1`, `foo.lano` y la recién creada `hello_dev`.

Arriba también podemos notar que con el comando `\c hello_dev` nos podemos cambiar a esa base de datos, y el comando `\dt` se pueden listar las tablas.

Ahora sí estamos listos para correr el servidor Phoenix en local:

```shell
$ mix phx.server
mix phx.server
[info] Running HelloWeb.Endpoint with cowboy 2.9.0 at 127.0.0.1:4000 (http)
[debug] Downloading esbuild from https://registry.npmjs.org/esbuild-darwin-arm64/-/esbuild-darwin-arm64-0.14.29.tgz
[info] Access HelloWeb.Endpoint at http://localhost:4000
[watch] build finished, watching for changes...
```

Ahora puedes apuntar tu navegador a `https://localhost:4000`.

Deberás de visualizar un error como el siguiente:

```json
{"errors": {"detail":"Not Found"}}
```

Esto es normal porque no se ha definido una ruta, en la siguiente sección se creará una ruta simple.

Ahora que tenemos nuestro primer proyecto corriendo, es aconsejable dejar el servidor corriendo en primer plano para estar viendo como llegan las peticiones al servidor web que se levanta en el puerto `4000`.

### Modificando el endpoint index

Ahora vamos a crear un ruta simple para el index del scope `/`, editamos el archivo `lib/hello_web/router.ex`:

```shell
$ vim lib/hello_web/router.ex
```

Después de el pipeline `:api` y el scope `/api` definimos el scope `/`:

```elixir
  scope "/", HelloWeb do
    pipe_through :api
    get "/", IndexController, :index
  end
```

***NOTA:*** El pipeline browser nos permite manejar peticiones en HTML.

Ahora creamos el controlador para el índice en `lib/hello_web/controllers`:

```shell
$ vim lib/hello_web/controllers/index_controller.ex
```

El contenido sería algo así:

```elixir
defmodule HelloWeb.IndexController do
  use HelloWeb, :controller

  def index(conn, _params) do
    text conn, "Hello World!"
  end
end
```

Ahora recargamos el navegador para volver a lanzar la petición, deberíamos de recibir el siguiente mensaje en respuesta:

```html
Hello World!
```

También podemos hacer la petición en tipo json con curl, por ejemplo:

```shell
$ curl -H "Content-Type: application/json" -X GET http://localhost:4000/
Hello World!
```

Verifiquemos que en la salida estándar del servidor Phoenix se registran las peticiones realizadas.

```shell
[info] GET /
[debug] Processing with HelloWeb.IndexController.index/2
  Parameters: %{}
  Pipelines: [:browser]
[info] Sent 200 in 926µs
```

Felicidades acabas de crear tu primer proyecto en elixir.

Si quieres ver un dashboard de la operación de Elixir nos dirigimos a la url: `http://localhost:4000/dashboard/home`.

## Ejecutando las pruebas

Cuando se crea un proyecto de Phoenix por default se incluyen unas pruebas, estas se pueden ejecutar así:

```shell
$ MIX_ENV=test mix test
..

Finished in 0.04 seconds (0.04s async, 0.00s sync)
2 tests, 0 failures
```

En otro momento hablaremos más de las pruebas.

## Haciendo commit a git

Antes de terminar preparamos el proyecto para subir los cambios a git:

```shell
$ cd ..
$ git checkout foo.lano/initial_api
$ git add .tool-versions
$ git commit -m "Add asdf elixir and erlang plugin versions" .tool-versions
$ mv src/.gitignore .
$ vim .gitignore
$ # Agrega prefijo /src a directorios _build, cover, deps, doc y .fetch
$ git add .gitignore
$ git commit -m "Update gitignore file with one created by phoenix." .gitignore
$ mv src/README.md .
$ git commit -m "Update README with one created by phoenix." README.md
$ git add src
$ git commit -m "Initial commit for elixir phoenix api." src
$ git push --set-upstream origin $(git_current_branch)
```

## Cambiando las configuraciones para tiempo de construcción

Ahora veremos un ejercicio en donde hacemos un poco más dinámica la página del índice de nuestra aplicación, cambiaremos un mensaje de su forma estática a una forma donde obtiene el valor desde un archivo de configuración en la aplicación.

Volvemos a modificar la página de índice y agregamos la siguiente línea:

```html
<p>Message from: <strong><%= Application.fetch_env!(:hello, :myconfig) %></strong></p>
```

En el archivo de configuración `config/config.exs` que es procesado en tiempo de construcción agregamos una llave y su valor:

```elixir
config :hello, myconfig: "config!"
```

Guardamos la configuración, terminamos el servidor Phoenix y lo volvemos a ejecutar para que reconstruya el proyecto y verifiquemos si se refleja el cambio, deberíamos ver el siguiente mensaje:

```
Message from: config!
```

Ahora definimos la llave en el archivo de configuración del ambiente de desarrollo `config/dev.exs`:

```
config :hello, myconfig: "dev!"
```

Guardamos la configuración y detenemos el servidor Phoenix, después volvemos a ejecutarlo para que se construya la nueva configuración, deberíamos ver el siguiente mensaje:

```
Message from: dev!
```

Como podemos ver, las configuraciones y sus valores para construir el proyecto se pueden definir en el archivo `config/config.exs`, esto aplica de forma general (a cualquier ambiente) y es leído antes de que compilamos nuestra aplicación, incluso antes de cargar nuestras dependencias, esto ayuda a definir cómo vamos a compilar el proyecto.

Si se quiere definir un parámetro específico para el ambiente de desarrollo se debe definir en `config/dev.exs`.

## Creando un endpoint para TODOs

Vamos a crear un endpoint en donde podemos registrar y consultar una lista de tareas.

```shell
$ mix phx.gen.context Todo Task tasks name:string:unique description:string completed:boolean
* creating lib/hello/todo/task.ex
* creating priv/repo/migrations/20220711024839_create_tasks.exs
* creating lib/hello/todo.ex
* injecting lib/hello/todo.ex
* creating test/hello/todo_test.exs
* injecting test/hello/todo_test.exs
* creating test/support/fixtures/todo_fixtures.ex
* injecting test/support/fixtures/todo_fixtures.ex

Remember to update your repository by running migrations:

    $ mix ecto.migrate

```

Ejecutamos las migraciones de la base de datos:

```shell
$ mix ecto.migrate
Compiling 2 files (.ex)
Generated hello app

21:49:45.215 [info]  == Running 20220711024839 Hello.Repo.Migrations.CreateTasks.change/0 forward

21:49:45.218 [info]  create table tasks

21:49:45.231 [info]  create index tasks_name_index

21:49:45.235 [info]  == Migrated 20220711024839 in 0.0s
```

Ejecutamos nuevamente los tests:

```shell
$ MIX_ENV=test mix test
Compiling 3 files (.ex)
Generated hello app
..........

Finished in 0.1 seconds (0.07s async, 0.04s sync)
10 tests, 0 failures

Randomized with seed 805128
```

Ahora creamos el modelo:

```shell
$ mix phx.gen.json Todo Task tasks name:string:unique description:string completed:boolean --no-schema --no-context
* creating lib/hello_web/controllers/task_controller.ex
* creating lib/hello_web/views/task_view.ex
* creating test/hello_web/controllers/task_controller_test.exs
* creating lib/hello_web/views/changeset_view.ex
* creating lib/hello_web/controllers/fallback_controller.ex

Add the resource to your :api scope in lib/hello_web/router.ex:

    resources "/tasks", TaskController, except: [:new, :edit]

```

Editamos el archivo del router y definimos la ruta:

```shell
$ vim lib/hello_web/router.ex
```

En el scope de `/api` agregamos el resource `/tasks`:

```elixir
  scope "/api", HelloWeb do
    pipe_through :api
    resources "/tasks", TaskController, except: [:new, :edit]
  end
```

## Haciendo peticiones a la API

Hacemos una petición para crear un registro:

```shell
$ curl -H "Content-Type: application/json" -X POST http://localhost:4000/api/tasks -d '{"task":{"name": "diviértete jugando con Phoenix", "description": "crear una API Elixir", "completed": false}}'
{"data":{"completed":false,"description":"crear una API Elixir","id":1,"name":"diviértete jugando con Phoenix"}}
```

Consultamos los registros:

```shell
$ curl -H "Content-Type: application/json" -X GET http://localhost:4000/api/tasks
{"data":[{"completed":false,"description":"crear una API Elixir","id":1,"name":"diviértete jugando con Phoenix"}]}
```

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
* [Elixir mix new task](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html)
* [Elixir - Compatibility and Deprecations](https://hexdocs.pm/elixir/1.12.3/compatibility-and-deprecations.html)
* [Staknine - Elixir Config and Environment Variables](https://staknine.com/elixir-config-environment-variables/)
* [Elixir - Introduction to Deployments](https://hexdocs.pm/phoenix/deployment.html)
* [Elixir - Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content)
* [Mix releases](https://hexdocs.pm/mix/Mix.Tasks.Release.html)
* [Postgres.app](https://postgresapp.com/)
