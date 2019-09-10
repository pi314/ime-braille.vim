function! s:Int2BitList (int) " {{{
    let l:int = a:int
    let l:result = [0, 0, 0, 0, 0, 0, 0, 0]
    for l:i in range(8)
        let l:result[(l:i)] = (l:int) % 2
        let l:int = l:int / 2
    endfor
    return l:result
endfunction " }}}
function! Test_Int2BitList () " {{{
    let v:errors = []
    call ime#log('braille', 'Test_Int2BitList()')
    call assert_equal(s:Int2BitList(0),   [0, 0, 0, 0, 0, 0, 0, 0])
    call assert_equal(s:Int2BitList(170), [0, 1, 0, 1, 0, 1, 0, 1])
    call assert_equal(s:Int2BitList(85),  [1, 0, 1, 0, 1, 0, 1, 0])
    call assert_equal(s:Int2BitList(157), [1, 0, 1, 1, 1, 0, 0, 1])
    call assert_equal(s:Int2BitList(255), [1, 1, 1, 1, 1, 1, 1, 1])
    for l:error in v:errors
        call ime#log('braille', l:error)
    endfor
    call ime#log('braille', 'Test_Int2BitList() ends')
endfunction " }}}


function! s:BitList2Int (bit_list) " {{{
    let l:result = 0
    for l:bit in reverse(copy(a:bit_list))
        let l:result = l:result * 2
        let l:result += l:bit
    endfor
    return l:result
endfunction " }}}
function! Test_BitList2Int () " {{{
    let v:errors = []
    call ime#log('braille', 'Test_BitList2Int()')
    call assert_equal(s:BitList2Int([0, 0, 0, 0, 0, 0, 0, 0]), 0)
    call assert_equal(s:BitList2Int([0, 1, 0, 1, 0, 1, 0, 1]), 170)
    call assert_equal(s:BitList2Int([1, 0, 1, 0, 1, 0, 1, 0]), 85)
    call assert_equal(s:BitList2Int([1, 0, 1, 1, 1, 0, 0, 1]), 157)
    call assert_equal(s:BitList2Int([1, 1, 1, 1, 1, 1, 1, 1]), 255)
    for l:error in v:errors
        call ime#log('braille', l:error)
    endfor
    call ime#log('braille', 'Test_BitList2Int() ends')
endfunction " }}}


function! ime_braille#handler (matchobj, trigger)
    if a:trigger == ' '
        " return an full braille symbol
        return {'len': 0, 'options': ['⣿']}
    else
        let l:braille_str = a:matchobj[0]
        let l:braille_num = char2nr(l:braille_str) - 0x2800
        if l:braille_num < 0
            let l:braille_num = 0
        endif
        let l:bit_list = s:Int2BitList(l:braille_num)
        let l:bit_index = index(s:ime_braille_keys_list, a:trigger)
        let l:bit_list[(l:bit_index)] = 1 - l:bit_list[(l:bit_index)]
        return [nr2char(0x2800 + s:BitList2Int(l:bit_list))]
    endif

    let l:braille_input_set = [0, 0, 0, 0, 0, 0, 0, 0]
    let l:ime_braille_keys_list = split(g:ime_braille_keys, '\zs')
    for i in range(strlen(l:braille_str))
        let l:braille_input_set[index(l:ime_braille_keys_list, l:braille_str[i])] = 1
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


function! ime_braille#info ()
    if !exists('g:ime_braille_keys') ||
                \ type(g:ime_braille_keys) != type('') ||
                \ len(g:ime_braille_keys) != 8
        let g:ime_braille_keys = '3ed4rfcv'
    endif

    let s:ime_braille_keys_list = split(g:ime_braille_keys, '\zs')

    return {
    \ 'type': 'standalone',
    \ 'icon': '[⢝]',
    \ 'description': 'Braille mode',
    \ 'pattern': '\v[⠀-⣿]?$',
    \ 'handler': function('ime_braille#handler'),
    \ 'trigger': s:ime_braille_keys_list + [' ']
    \ }
endfunction
