set fish_greeting "The Quieter You Are, The More You Are Able To Listen"

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme dracula
set -g fish_prompt_pwd_dir_length 0 # change to 1 to not see full directory length
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_display_user ssh
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_hostname always
set -g fish_key_bindings fish_vi_key_bindings
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_nerd_fonts yes


# aliases
alias ll "exa --long --header --all --git --classify --modified --created --git --icons"
alias lla "exa --long --header --all --git --classify--accessed --modified --created --git --icons"
alias llt "exa --long --header --all --git --classify --accessed --modified --created --tree --level=2 --git --icons"
# alias ls "ls -p -G"
# alias la "ls -A"
# alias ll "ls -l"
# alias lla "ll -A"
alias g git
command -qv nvim &&
# alias vim nvim
alias fishprofile='nvim ~/.config/fish/config.fish'
alias nvimprofile='nvim ~/.config/nvim/init.lua'
alias restart='source ~/.config/fish/config.fish'
alias lvim-gui='~/.local/bin/lvim-gui'
alias reach='~/reach/reach'

set -gx EDITOR nvim

set -gx PATH bin "$PATH"
set -gx PATH ~/bin "$PATH"
set -gx PATH "~/.local/bin:$PATH"

# NodeJS
# set -gx PATH "node_modules/.bin:$PATH"
set -g NODE_JS ".npm-packages/"
set -gx PATH "$NODE_JS/bin:$PATH"

# ANDROID_SDK
set -g ANDROID_HOME "$HOME/Android/Sdk"
set -gx PATH "$ANDROID_HOME:$PATH"

set -g ANDROID_SDK_ROOT "$HOME/Android/Sdk"
set -gx PATH "$ANDROID_SDK_ROOT:$PATH"

# ANDROID_EMULATOR
set -g ANDROID_EMULATOR "$ANDROID_HOME/emulator"
set -gx PATH "$ANDROID_EMULATOR:$PATH"

# ANDROID_PLATFORM_TOOLS
set -g ANDROID_PLATFORM_TOOLS "$ANDROID_HOME/platform-tools"
set -gx PATH "$ANDROID_PLATFORM_TOOLS:$PATH"

# JAVA_HOME
set -g JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64/bin"
set -gx PATH "$JAVA_HOME:$PATH"

# Go
set -g GOPATH "$HOME/go"
set -gx PATH "$GOPATH/bin:$PATH"

# Global path
set PATH "$HOME/bin:$PATH"

# NVM
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    # Do nothing
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f "$LOCAL_CONFIG"
  source "$LOCAL_CONFIG"
end

# Bun
set -Ux BUN_INSTALL "/home/chara/.bun"
set -px --path PATH "/home/chara/.bun/bin"
