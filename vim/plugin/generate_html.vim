"
" <This plugin generates html tags to new html files>
" https://stackoverflow.com/questions/690386/writing-a-vim-function-to-insert-a-block-of-static-text/34951126#34951126
"

autocmd BufNewFile  *.html  call    Generate_html()

function! Generate_html()
    call append(0, "<!DOCTYPE HTML>")
    call append(1, "<html>")
    call append(2, "<head>")
    call append(3, '    <style>')
    call append(4, '    ')
    call append(5, '    </style>')
    call append(6, '</head>')
    call append(7, '<body>')
    call append(8, '')
    call append(9, '</body>')
    call append(10,'</html>')
endfunction
