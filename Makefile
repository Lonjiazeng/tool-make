
all: build-essential vim zsh oh-myzsh c_cpp

build-essential: 
	@sudo apt-get update -y
	@sudo apt-get upgrade -y
	@sudo apt-get install build-essential
	@echo installed build-essential

vim: configdir 
	@cd ./configdir
	@git clone https://github.com/vim/vim.git
	@./configure --with-features=huge \
				--enable-multibyte \
				--enable-rubyinterp=dynamic \
				--with-ruby-command=/usr/bin/ruby \
				--enable-pythoninterp=dynamic \
				--with-python-config-dir=/usr/lib/python2.7/config \
				--enable-python3interp=dynamic \
				--with-python3-config-dir=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin \
				--enable-cscope \
				--enable-gui=auto \
				--enable-gtk2-check \
				--enable-fontset \
				--enable-largefile \
				--disable-netbeans \
				--with-compiledby="yyq123@email.com" \
				--enable-fail-if-missing \
				--prefix=/usr/local
	@sudo make
	
zsh: 
	@sudo apt-get update -y
	@sudo apt-get upgrade -y
	@sudo apt-get install zsh -y
	@echo zsh installed
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	@chsh -s $(which zsh)
	@cp .zshrc ~/
	@git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
	@git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	@git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	@cp ./.p10k.zsh ~/
	@source .zshrc


configdir:
	@cd ~
	@mkdir configdir
	@echo "configdir finish"



