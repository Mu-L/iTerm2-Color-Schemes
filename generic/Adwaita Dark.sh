#!/bin/sh
# Adwaita Dark

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "24/1f/31"
put_template 1  "c0/1c/28"
put_template 2  "2e/c2/7e"
put_template 3  "f5/c2/11"
put_template 4  "1e/78/e4"
put_template 5  "98/41/bb"
put_template 6  "0a/b9/dc"
put_template 7  "c0/bf/bc"
put_template 8  "5e/5c/64"
put_template 9  "ed/33/3b"
put_template 10 "57/e3/89"
put_template 11 "f8/e4/5c"
put_template 12 "51/a1/ff"
put_template 13 "c0/61/cb"
put_template 14 "4f/d2/fd"
put_template 15 "f6/f5/f4"

color_foreground="ff/ff/ff"
color_background="1d/1d/20"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "ffffff"
  put_template_custom Ph "1d1d20"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "ffffff"
  put_template_custom Pk "5e5c64"
  put_template_custom Pl "ffffff"
  put_template_custom Pm "1d1d20"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
