#!/usr/bin/env bash

zimfw::install() {
  script::depends_on curl
  
  export ZIM_HOME="${ZIM_HOME:-${DOTFILES_PATH}/shell/zimfw}"

  curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh 2>&1
  
  zsh "${ZIM_HOME}/zimfw.zsh" install 2>&1

  zimfw::is_installed
}

zimfw::is_installed() {
  [[ -r "${ZIM_HOME}/zimfw.zsh" ]] && command -v git &> /dev/null
}

zimfw::is_outdated() {
  [[ $(platform::semver_compare "$(zimfw::latest)" "$(zimfw::version)") -gt 0 ]]
}

zimfw::upgrade() {
  zsh -c ". \"${HOME}/.zshrc\"; \"${ZIM_HOME}/zimfw.zsh\" clean; \"${ZIM_HOME}/zimfw.zsh\" update; \"${ZIM_HOME}/zimfw.zsh\" upgrade; \"${ZIM_HOME}/zimfw.zsh\" compile"
}

zimfw::description() {
  echo "Zim is a Zsh configuration framework with blazing speed and modular extensions"
}

zimfw::url() {
  echo "https://zimfw.sh"
}

zimfw::version() {
  zsh -c ". \"${HOME}/.zshrc\"; \"${ZIM_HOME}/zimfw.zsh\" version"
}

zimfw::latest() {
  git::remote_latest_tag_version 'git@github.com:zimfw/zimfw.git' 'v*.*.*'
}

zimfw::title() {
  echo -n "ZIM:FW"
}
