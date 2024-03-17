if [ ! -e /run/.containerenv ] && [ ! -e /.dockerenv ] && [ -d "/home/linuxbrew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
