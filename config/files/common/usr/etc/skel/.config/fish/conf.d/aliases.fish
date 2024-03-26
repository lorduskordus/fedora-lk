# Global aliases
if test -e $HOME/.aliases
	. $HOME/.aliases
end

# Host only aliases
if test ! -e /run/.containerenv -a ! -e /.dockerenv
    if test -e $HOME/.aliases-host-only
		. $HOME/.aliases-host-only
	end

# Container only aliases
else
	if test -e $HOME/.aliases-container-only
		. $HOME/.aliases-container-only
	end
end