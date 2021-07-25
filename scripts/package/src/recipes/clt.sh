#!/usr/bin/env bash

# Command Line Tools
# Useful for dependencies of CLT
# https://developer.apple.com/downloads/index.action

# This install function was created using brew installation script as reference
clt::install() {
  if ! platform::is_macos; then
    output::error "This package is only for macOS"
    return 1
  fi

  if clt::is_installed; then
    output::answer "Reinstall of Command Line Tools is not possible without uninstalling first"
    return 1
  fi

  local -r placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
  /usr/bin/touch "$placeholder" # Force softwareupdate to list CLT

  local -r clt_label="$(/usr/sbin/softwareupdate -l | grep -B 1 -E 'Command Line Tools' | awk -F '*' '/^ *\\*/ {print $2}' | sed -e 's/^ *Label: //' -e 's/^ *//' | sort -V -r |
    head -n1)"

  if ! /usr/bin/sudo -v -B; then
    output::error "Can not be installed without sudo authentication first"
    return 1
  fi

  if [[ -n "$clt_label" ]]; then
    /usr/bin/sudo /usr/sbin/softwareupdate -i "$clt_label"
    /usr/bin/sudo /usr/bin/xcode-select --switch "/Library/Developer/CommandLineTools"
  fi
  # Remove the placeholder always
  /bin/rm -f "$placeholder"

  # Something was terriby wrong with the CLT installation, so we need to try with another method
  if ! clt::is_installed && sudo -v -B; then
    /usr/bin/xcode-select --install
    if [[ "${DOTLY_ENV:-PROD}" != "CI" ]]; then
      until xcode-select --print-path &> /dev/null; do
        output::answer "Waiting for Command Line tools to be installed... Check again in 10 secs"
        sleep 10
      done
    fi

    {
      [[ -d "/Library/Developer/CommandLineTools" ]] &&
      sudo xcode-select --switch /Library/Developer/CommandLineTools
    } || output::answer "Command Line Tools could not be selected"
  fi

  if ! output="$(/usr/bin/xcrun clang 2>&1)" && [[ "$output" == *"license"* ]]; then
    output::error "Command Line Tools could not be installed because you do not have accepted the license"
    return 1
  fi

  clt::is_installed && output::solution "Command Line Tools installed"
}

clt::is_installed() {
  platform::is_macos && platform::command_exists /usr/bin/xcode-select && xpath=$(/usr/bin/xcode-select --print-path) && test -d "${xpath}" && test -x "${xpath}"
}

clt::uninstall() {
  if ! clt::is_installed; then
    return
  fi

  # Remove Command Line Tools
  local -r clt_path="$(/usr/bin/xcode-select --print-path)"

  if ! sudo -v -B; then
    output::error "Can not uninstall without sudo"
  fi

  sudo rm -rf "${clt_path}"

  ! commmand-line-tools::is_installed && output::solution "Command Line Tools uninstalled"
}
