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
$ mix archive.install hex phx_new 1.5.9

Resolving Hex dependencies...
Dependency resolution completed:
New:
  phx_new 1.5.9
* Getting phx_new (Hex package)
All dependencies are up to date
Compiling 10 files (.ex)
Generated phx_new app
Generated archive "phx_new-1.5.9.ez" with MIX_ENV=prod
```

```shell
$ mix phx.new src --app hello
```
## Referencias

Leer las siguientes referencias adicionales para complementar la guía:

 * [asdf](https://asdf-vm.com/)
 * [Install Elixir using asdf](https://thinkingelixir.com/install-elixir-using-asdf/)
 * [Phoenix Framework](https://www.phoenixframework.org/)
