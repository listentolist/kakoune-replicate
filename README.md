# Replicate -- REPL Plugin for Kakoune

This plugin provides commands for REPL interaction in the Kakoune text
editor.

## Dependencies

- [GNU Screen](https://www.gnu.org/software/screen/)

## Installation

Clone the repository into the `autoload` directory.

## Usage

At first run:

```
:require-module replicate
```

### One REPL

If you do not need more than one REPL, the following commands are all
you need.

Start a new REPL:

```
:replicate-start
```

Send the current selection to the REPL:

```
:replicate-send
```

### Multiple REPLs

If you want to have more than one REPL, you can set IDs for them. There
are two ways:

1. Explicitly address one specific REPL by passing the ID as an argument
to the commands.

  ```
  :replicate-start julia
  ```

  This starts a REPL with the ID `julia`. Now you can send a selection to
  that REPL with

  ```
  :replicate-send julia
  ```

2. Set the option `replicate_id` for some scope.

  ```
  :set-option buffer replicate_id "guile"
  ```

  After that the commands `replicate-start` and `replicate-send` use the
  REPL with the ID `guile`, when they are run in that buffer.

### Scratch Buffer

You can open a scratch buffer with the current `filetype` and `replicate_id`
by running:

```
replicate-scratch
```

## Options

- `str replicate_id`, default: "default"\
  The name of the REPL ID that is used for the commands `replicate-start`
  and `replicate-send`, when they are run without any argument.

## Commands

- `replicate-start [<id>]`:\
  Start a REPL with the given ID.\
  If no `<id>` is given the `replicate_id` of the current scope is used.

- `replicate-scratch`\
  Opens a replicate scratch buffer.\
  `replicate_id` and `filetype` of the current scope are used.

- `replicate-send [<id>]`:\
  Send selection to REPL with the given ID.\
  If no `<id>` is given the `replicate_id` of the current scope is used.
