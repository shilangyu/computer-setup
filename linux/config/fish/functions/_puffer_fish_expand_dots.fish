function _puffer_fish_expand_dots -d 'expand .. to ../ etc'
    set tok (commandline --cut-at-cursor --current-token)
    if string match --quiet --regex -- '^(\.\./)*\.$' $tok
        commandline --insert './'
    else
        commandline --insert '.'
    end
end
