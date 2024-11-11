let a = printenv | split row "\n" | str join " "

kitten @ env $a
kitten @ launch --type=tab --keep-focus
