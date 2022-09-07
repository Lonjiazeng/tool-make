
all:  vim zsh oh-myzsh c_cpp

cmake: 
	@sudo apt-get update -y
	@sudo apt-get upgrade -y
	@sudo apt-get install cmake
	@echo cmake installed

vim: configdir ccls
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
	@echo vim installed
	
ccls: configdir cmake
	@sudo apt-get update -y && sudo apt-get upgrade -y
	@sudo apt-get install clang -y
	@sudo apt-get install libclang-10-dev -y
	@cd configdir
	@git clone --depth=1 --recursive https://github.com/MaskRay/ccls
	@cd ccls
	@cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
						-DCMAKE_PREFIX_PATH=/usr/lib/llvm-10 \
						-DLLVM_INCLUDE_DIR=/usr/lib/llvm-10/include \
						-DLLVM_BUILD_INCLUDE_DIR=/usr/include/llvm-10/

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
	@echo zsh installed

configdir:
	@cd ~
	@mkdir configdir
	@echo "configdir finish"



