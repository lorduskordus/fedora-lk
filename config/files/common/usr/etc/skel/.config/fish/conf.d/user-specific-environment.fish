if not contains -- "$HOME/.local/bin:$HOME/bin:" $PATH
	set -gx PATH "$HOME/.local/bin:$HOME/bin:$PATH"
end