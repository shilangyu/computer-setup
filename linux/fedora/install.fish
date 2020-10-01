cp config/* ~/.config

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf copr enable evana/fira-code-fonts

sudo dnf check-update

set dnf_packages \
	rpmfusion-free-release \
	rpmfusion-nonfree-release \
	alacritty
	cargo \
	chromium \
	clang-tools-extra \
	ImageMagick \
	cmatrix \
	code \
	discord \
	ffmpeg \
	fira-code-fonts \
	firefox \
	fzf \
	gnome-tweaks \
	golang \
	gimp \
	mediainfo \
	mpv \
	neofetch \
	nodejs \
	p7zip \
	pandoc \
	rust \
	neovim \
	texlive \
	scrcpy \
	simplescreenrecorder \
	telegram-desktop \
	visualboyadvance-m \
	xclip \
	youtube-dl \
	yarn \

sudo dnf install -y $dnf_packages
sudo dnf upgrade -y

set cargo_packages \
	lsd \
	starship \
	bottom \
	mdbook \
	dua-cli \
	fd-find \
	hyperfine \
	ripgrep \
	bat \
	cargo-expand \
	deno \
	hx \
	tokei \
	watchexec \
	zoxide \


for crate in $cargo_packages
	cargo install $crate
end

set go_packages \
	github.com/shilangyu/brainfuck \
	github.com/shilangyu/omnirun \
	github.com/shilangyu/typer-go \
	github.com/claudiodangelis/qrcp \

for gopkg in $go_packages
	go get $gopkg
end

set pip_packages \
	numpy \
	matplotlib \
	pipreqs \

for pippkg in $pip_packages
	pip install -y $pippkg
end
