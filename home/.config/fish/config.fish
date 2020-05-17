set -g theme_title_display_process yes
set -g theme_color_scheme gruvbox
set -g theme_date_format "+%H:%M"
set -g theme_date_timezone Europe/Zurich

function __bell_on_postexec --on-event fish_postexec
    echo -ne "\a"
end
