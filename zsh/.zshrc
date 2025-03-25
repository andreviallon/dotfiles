# Add the following to .zshenv for .zshrc file in .config to work
# export ZDOTDIR="$HOME/.config/zsh"


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/Users/andreviallon/.volta/bin:$PATH"

alias nrd="nx run manager:serve:dev"
alias nrl="nx run manager:serve:local"
alias nrg="nx run graphqlv2-manager:serve"
alias nrgi="nx run graphql-internal:serve"
alias y="yarn"
alias ys="yarn scripts"
alias ysa="yarn scripts --all"

alias lg="lazygit"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-chad="NVIM_APPNAME=nvchad nvim"

function nvims() {
  items=("default" "LazyVim" "nvchad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/andreviallon/.lmstudio/bin"

eval "$(fzf --zsh)"
