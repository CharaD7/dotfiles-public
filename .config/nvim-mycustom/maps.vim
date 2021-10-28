" Description: Keymaps

let mapleader=";"

" Prevent CTRL+Z suspending Vim
nnoremap <c-z> <nop

nnoremap <S-C-p> "0p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" After searching, pressing escape stops the highlight
nnoremap <silent> <esc> :noh<cr><esc>
vnoremap <silent> <esc> :noh<cr><esc>

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Delete a word backwards
" nnoremap dw vb"_d

" Move lines up or down
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Select all
nmap <C-a> gg<S-v>G

" Open nvimrc file
nnoremap <leader>v :vsp $MYVIMRC<CR>

" Source nvimrc file
nnoremap <leader>sv :source $MYVIMRC<CR>

" Quick new file
nnoremap <Leader>n :enew<CR>

"Auto close tags
imap ,/ </<C-X><C-O>

" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Save with root permission
command! W w !sudo tee > /dev/null %
map <leader>w :write<Return> " For saving

" Toggle Commentary
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>


" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"-----------------------------
" Tabs

" Open current directory
nmap te :tabedit 
nmap <S-Tab> :bprevious<Return>
nmap <Tab> :bnext<Return>
nmap <C-d> :bdelete<Return>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Close window
nmap sx :close<Return> 
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-


" NERDTree Configuration
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

