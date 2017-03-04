function! s:Handler (matchobj)
    let l:braille_str = a:matchobj[0]
    if strlen(l:braille_str) == 0
        return ' '
    endif

    let l:braille_input_set = [0, 0, 0, 0, 0, 0, 0, 0]
    let l:boshiamy_braille_keys_list = split(g:boshiamy_braille_keys, '\zs')
    for i in range(strlen(l:braille_str))
        let l:braille_input_set[index(l:boshiamy_braille_keys_list, l:braille_str[i])] = 1
    endfor

    let l:braille_value = 0
    let l:probe = 1
    for i in l:braille_input_set
        if i == 1
            let l:braille_value += l:probe
        endif
        let l:probe = l:probe * 2
    endfor
    return [nr2char(l:braille_value + 0x2800)]
endfunction


function! boshiamy_braille#info ()
    if !exists('g:boshiamy_braille_keys') ||
                \ type(g:boshiamy_braille_keys) != type('') ||
                \ len(g:boshiamy_braille_keys) != 8
        let g:boshiamy_braille_keys = '7uj8ikm,'
    endif

    return {
    \ 'type': 'standalone',
    \ 'icon': '[⢝]',
    \ 'description': 'Braille mode',
    \ 'pattern': '\v['. g:boshiamy_braille_keys .']+$',
    \ 'handler': function('s:Handler'),
    \ }
endfunction
