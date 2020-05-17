function aur-devel
    set aurvcs '(-git|-hg)$'
    aur sync (aur repo --list | cut -f1 | grep -E $aurvcs | tr '\n' ' ') --no-ver --print
    aur sync --no-ver-shallow (aur vercmp-devel | cut -d: -f1 | tr '\n' ' ')
end
