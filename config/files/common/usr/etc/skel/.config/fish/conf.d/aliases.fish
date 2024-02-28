# Aliases

# Global aliases
if test -e ~/.aliases
	. ~/.aliases
end

# Host only aliases
if test ! -e /run/.containerenv -a ! -e /.dockerenv
    if test -e ~/.aliases-host-only
		. ~/.aliases-host-only
	end

# Container only aliases
else
	if test -e ~/.aliases-container-only
		. ~/.aliases-container-only
	end
end