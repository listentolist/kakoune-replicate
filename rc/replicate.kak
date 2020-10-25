provide-module replicate %§

# replicate_id
declare-option -docstring %{
    name that is used to identify the screen session
  } str replicate_id "default"

# replicate-start
define-command -override -params 0..1 -docstring %{
    replicate-start [<id>]: start a REPL with the given id
    if no <id> is given the replicate_id of the current scope is used
  } replicate-start %{
  terminal sh -c %{
    screen -S "replicate-${1:-$2}"
  } -- %arg{1} %opt{replicate_id}
}

# replicate-send
define-command -override -params 0..1 -docstring %{
    replicate-send [<id>]: send selection to REPL with the given id
    if no <id> is given the replicate_id of the current scope is used
  } replicate-send %{
  nop %sh{
    selection=$(printf %s "$kak_selection" \
              | sed -Eze 's/[$^\]/\\&/g' -e 's/\n/\\n/g')
    screen -S "replicate-${1:-$kak_opt_replicate_id}" -X stuff "$selection"
  }
}

# replicate-scratch
define-command -override -docstring %{
    replicate-scratch: opens a replicate scratch buffer
    replicate_id and filetype of the current scope are used
  } replicate-scratch %{
  evaluate-commands -save-regs 'ab' %{
    set-register a %opt{replicate_id}
    set-register b %opt{filetype}
    edit -scratch "*replicate-%reg{a}*"
    set-option buffer replicate_id %reg{a}
    set-option buffer filetype %reg{b}
  }
}

§
