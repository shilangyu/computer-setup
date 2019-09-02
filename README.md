# computer-setup

Setup for a new computer (windows).

## table of contents

- [usage](#usage)
- [structure](#structure)
- [folders](#folders)
  - [cmder](#cmder)
  - [fonts](#fonts)
  - [golang](#golang)
  - [npm](#npm)
  - [powershell](#powershell)
  - [programs](#programs)
  - [python](#python)
  - [vs-code](#vs-code)

---

### usage

This repo has my personal setup, to configure it fork the repo and change the `config.json`s and `data`s. See: [structure](#structure)
To start the installation run the `install.ps1` from the root directory. It will first install `programs/` and then all the rest.

---

### structure

each subfolder follows this structure:

```
subfolder/
	data/
		file1
		file2
	config.json
	install.ps1
```

- Each `install.ps1` section should have a comment describing what it is doing.
- Avoid using aliases in `install.ps1`.
- Configuring a subfolder should be done only by changing the `config.json` or inserting files to `data/`.
- When creating your own folders make sure to follow the same structure.

---

## folders

### cmder

- `config.json`: _nothing_
- `data/`: `settings.xml` to be installed

### golang

- `config.json`:

```
{
	"packages": string[](packages to be `go get`)
}
```

- `data/`: _nothing_

### npm (through pnpm)

- `config.json`:

```
{
	"global": string[](packages to be installed globally)
}
```

- `data/`: _nothing_

### powershell

- `config.json`: _nothing_

- `data/`: `profile.ps1` to be installed

### programs

- `config.json`:

```

{
  "buckets": string[](scoop buckets to be added),
  "programs": string[](programs to be installed by scoop),
}

```

- `data/`: _nothing_

### python

- `config.json`:

```

{
  "global": string[](packages to be installed globally)
}

```

- `data/`: `.whl` files to be installed

### vs-code

- `config.json`:

```

{
  "extensions": string[](extensions to be installed)
}

```

- `data/`:

```

snippets/
lang1.json
lang2.json
lang3.json
keybindings.json
settings.json

```
