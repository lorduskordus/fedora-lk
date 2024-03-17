if test ! -e /run/.containerenv -a ! -e /.dockerenv -a -d "/home/linuxbrew"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end
