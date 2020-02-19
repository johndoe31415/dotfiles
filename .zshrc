# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use grmls zshrc + antigen.

# {{{ functions

# Initial setup for zshrcs. Runs in a subshell.
function bootstrap {
	echo "Bootstrapping config files."

	mkdir -p $HOME/.zsh

	local url="https://github.com/andreas-hofmann/dotfiles/raw/master"

	echo "Fetching .zlogout..."
	curl --progress-bar -L $url/.zlogout		> $HOME/.zlogout
	echo "Fetching .p10k.zsh..."
	curl --progress-bar -L $url/.p10k.zsh		> $HOME/.p10k.zsh
	echo "Fetching .zsh/zshrc.local..."
	curl --progress-bar -L $url/.zsh/zshrc.local	> $HOME/.zsh/zshrc.local
	echo "Fetching .zsh/zshrc.antigen..."
	curl --progress-bar -L $url/.zsh/zshrc.antigen	> $HOME/.zsh/zshrc.antigen
	echo "Fetching .zsh/zshrc.grml..."
	curl --progress-bar -L $url/.zsh/zshrc.grml	> $HOME/.zsh/zshrc.grml

	echo "Fetching .zsh/antigen.zsh..."
	curl --progress-bar -L git.io/antigen		> ${HOME}/.zsh/antigen.zsh
	#curl --progress-bar -L $url/.zsh/antigen.zsh	> $HOME/.zsh/antigen.zsh

	echo "Updating .zshrc..."
	curl --progress-bar -L $url/.zshrc		> $HOME/.zshrc
	
	echo "Done. Restart the shell!"
}

# }}}

# {{{ Source the individual configs.

if [ ! -r "${HOME}/.zsh/zshrc.local" ] ; then
	echo " zsh not set up. Call bootstrap()!"
else
	source ${HOME}/.zsh/zshrc.grml

	prompt off

	source ${HOME}/.zsh/zshrc.antigen

	source ${HOME}/.zsh/zshrc.local

	if [ -x /usr/bin/direnv ]; then
		eval "$(/usr/bin/direnv hook zsh)"
	fi
fi
 
# }}}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
