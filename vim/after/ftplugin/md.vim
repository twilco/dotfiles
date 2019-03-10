""" re-enable line wrapping for markdown files

" :h fo-table - Auto-wrap text using textwidth
set formatoptions+=t
 
set wrap
" don't break until word is done
set linebreak
" list disables linebreak
set nolist
" prevent vim from automatically inserting hard linebreaks
set textwidth=0 wrapmargin=0
