# computer-setup
Setup for a new computer (windows).

## table of contents
- [usage](#usage)
- [structure](#structure)
- [folders](#folders)
	- [fonts](#fonts)
	- [golang](#golang)
	- [npm](#npm)
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

### fonts
- `config.json`: _nothing_
- `data/`: `.ttf` font files to be installed

### golang
- `config.json`: 
```json
{ 
	"packages": string[](packages to be `go get`)
}
```
- `data/`: _nothing_

### npm
- `config.json`: 
```json
{ 
	"global": string[](packages to be installed globally)
}
```
- `data/`: _nothing_

### programs
- `config.json`: 
```json
{ 
	"programs": string[](programs to be installed by chocolatey)
}
```
- `data/`: _nothing_

### python
- `config.json`: 
```json
{ 
	"global": string[](packages to be installed globally)
}
```
- `data/`: `.whl` files to be installed

### vs-code
- `config.json`: 
```json
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
