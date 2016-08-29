#!/bin/bash

# Run both lemonbar scripts

killall lemonbar

col_top="#101010"
col_bot="#101010"

dim_top="-g x20"
dim_bot="-g x18"

font_top="-f Roboto Mono:style=Light:size=10"
font_bot=$font_top

($HOME/.config/lemonbar/top.sh | lemonbar -B $col_top $dim_top "$font_top")&
($HOME/.config/lemonbar/bottom.sh | lemonbar -b -B $col_bot $dim_bot "$font_bot")&