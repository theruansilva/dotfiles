###############################################################################
# fzf
#
# fzf is a general-purpose command-line fuzzy finder.
#
# https://github.com/junegunn/fzf
#
# File locations:
# - ~/.fzf
# - ~/.fzf.bash
# - ~/.fzf.zsh
# - ~/.profile.d/fzf.sh
###############################################################################

# Dracula Theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7

'
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --border
  --margin=1
  --padding=1
  --height=80%
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-l:up,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle'
  "

export FZF_CTRL_T_OPTS="
  --border
  --margin=1
  --padding=1
  --height=80%
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-l:up,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle'"

# Tmux
# export FZF_TMUX_OPTS='-p80%,60%'

# Options to fzf command
# export FZF_COMPLETION_TRIGGER=''
export FZF_COMPLETION_OPTS=' --height=40% --layout=reverse --info=inline --border --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle,ctrl-l:up''

# Commands
# Open File or Directory
ff() {
  IFS=$'\n' files=($(fzf-tmux -p80%,60%  --preview 'bat -n --color=always {}' --query="$1" --multi --select-1 --reverse --exit-0  --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-l:up,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle'  ))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

ii() {
  IFS=$'\n' files=($(fzf-tmux -p80%,60%  --preview 'bat -n --color=always {}' --query="$1" --multi --select-1 --reverse --exit-0  --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-l:up,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle'  ))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac --reverse --border --height=40% --bind 'ctrl-j:accept,ctrl-q:abort,ctrl-p:backward-delete-char,ctrl-l:up,ctrl-a:beginning-of-line,ctrl-s:end-of-line,ctrl-k:down,ctrl-w:backward-kill-word,ctrl-e:kill-word,ctrl-m:forward-word,ctrl-n:backward-word,tab:toggle'| sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# Another CTRL-T script to select a directory and paste it into line
ffs ()
{
  builtin typeset READLINE_LINE_NEW="$(
    command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
            -prune \
            -o -type f -print \
            -o -type d -print \
            -o -type l -print 2>/dev/null \
    | command sed 1d \
    | command cut -b3- \
    | env fzf -m
  )"

  if
    [[ -n $READLINE_LINE_NEW ]]
  then
    builtin bind '"\er": redraw-current-line'
    builtin bind '"\e^": magic-space'
    READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
    READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
  else
    builtin bind '"\er":'
    builtin bind '"\e^":'
  fi
}

# Select a running docker container to stop
function dkp() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Setup fzf
if [[ ! "$PATH" = /usr/share/fzf/* ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- =~ i ]] && source "/usr/share/fzf/completion.zsh"

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.zsh"
