function _puffer_fish_expand_tilde -d 'expand ~ to ~/'
    set tok (commandline --cut-at-cursor --current-token)
    if test $tok = ""
        commandline --insert '~/'
    else
        commandline --insert '~'
    end
end
