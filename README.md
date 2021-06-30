<p align="center">
  <a href="https://github.com/gtrabanco/sloth">
    <img src="sloth.svg" alt="Sloth Logo" width="256px" height="256px" />
  </a>
</p>

<h1 align="center">
  Dotfiles for laziness
</h1>

<p align="right">
  Original idea is <a href="https://github.com/codelytv/dotly" alt="Dotly repository">Dotly Framework</a> by <a href="https://github.com/rgomezcasas" alt="Dotly orginal developer">Rafa Gomez</a>
</p>

## Main differences and features with Dotly Framework
* Abstraction from Framework loader you only need to add `source "${SLOTH_PATH:-$DOTLY_PATH}/shell/init-sloth.sh"`
* Init scripts (see (init-scripts)[https://github.com/gtrabanco/dotfiles/tree/master/shell/init.scripts] in (gtrabanco/dotfiles)[https://github.com/gtrabanco/dotfiles]). This provides many possibilities as modular loading of custom variables or aliases by machine, loading secrets... Whatever you can imagine.
* Per machine (or whatever name you want to) export packages `sloth packages dump` (you can use `dot` instead of `sloth`, we also have aliases for this command like `lazy` and `s`).
* Non opinionated `git` scripts.
* Compatibility with all Dotly features and scripts.
* When you install SLOTH a backup of all files that well be linked is done (`.bashrc`, `.zshrc`, `.zshenv`... All files in symlinks/conf.yaml and equivalent files that are applied with `sloth core install`). So you won't loose any old data if you migrate to SLOTH.
* Easy way to create new scripts from Terminal `sloth script create --help`
* Easy way to install scripts from Terminal `sloth script install_remote --help`
* Use libraries without download `. <(https://raw.githubusercontent.com/gtrabanco/sloth/master/scripts/core/src/output.sh) && output::write "Using latest output.sh library of SLOTH"`
* Execute scripts without download (as installer) `bash <(https://raw.githubusercontent.com/gtrabanco/dotfiles/master/restoration_scripts/98-keybase-import-private-key.sh)`
* Scripts marketplace (Coming soon...)
* We promise to reply all issues and support messages and review PRs.

## Migration from Dotly

If you have currently dotly in your .dotfiles you can migrate.

Using wget
```bash
bash <(wget -qO- https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/dotly-migrator)
```

Using curl
```bash
bash <(curl -s https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/dotly-migrator)
```

## INSTALLATION

### Linux, macOS, FreeBSD

Using wget
```bash
bash <(wget -qO- https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/installer)
```

Using curl
```bash
bash <(curl -s https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/installer)
```

## Restoring dotfiles

In your repository you see a way to restore your dotfiles, anyway you can restory by using the restoration script.

### Linux, macOS, FreeBSD

Using wget
```bash
bash <(wget -qO- https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/restorer)
```

Using curl
```bash
bash <(curl -s https://raw.githubusercontent.com/gtrabanco/sloth/HEAD/restorer)
```

<hr>

## Roadmap

View [Wiki](https://github.com/gtrabanco/sloth/wiki#roadmap) if you want to contribute and you do not know what to do or maybe is already a WIP (Work in Progress).
