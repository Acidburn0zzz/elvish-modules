# DO NOT EDIT THIS FILE DIRECTLY
# This is a file generated from a literate programing source file located at
# https://github.com/zzamboni/elvish-modules/blob/master/terminal-title.org
# You should make any changes there and regenerate it from Emacs org-mode using C-c C-v t

use ./prompt-hooks
use re

start = "\e]0;"
end = "\007"

fn set-title [title]{
  print $start$title$end
}

title-during-prompt = {
  put "elvish "(tilde-abbr $pwd)
}

title-during-command = [cmd]{
  put (re:split '\s' $cmd | take 1)" "(tilde-abbr $pwd)
}

fn init {
  prompt-hooks:add-before-readline {
    set-title ($title-during-prompt)
  }
  prompt-hooks:add-after-readline [cmd]{
    set-title ($title-during-command $cmd)
  }
}

init
