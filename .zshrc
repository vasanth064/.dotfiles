#----------------------------------------------------------------------------------------------ALIAS-----------------------------------------------------------------------------------------#
#                                                                                                                                                                                            #
#                                                                                                                                                                                            #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#Extras
export EDITOR='nano'
export PATH="/opt/webstorm/bin:$PATH"

alias wscrcpy='scrcpy --tcpip=192.168.240.112 --max-size=1440'

#System
alias update='sudo dnf update'
alias upgrade='sudo apt upgrade'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias aremove='sudo dnf auto-remove'
alias rm='rm -rv'
alias cls='clear'
alias gedit='gnome-text-editor'
alias search='sudo dnf search'
alias sgedit='gnome-text-editor'
alias snano='sudo nano'

#Git
alias gcl='git clone'
alias gc='git commit -m'
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'

#Git for dotfiles
alias dg='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias dgc='dg commit -m'
alias dga='dg add'
alias dgs='dg status'
alias dgp='dg push'
alias dgpl='dg pull'

#Yarn
alias yi='yarn install'
alias ys='yarn start'
alias yd='yarn dev'
alias ya='yarn add'
alias yr='yarn remove'

#Development
alias mysql='mysql -u root'
export PATH="$PATH:/home/vasanth/.local/bin"

#Django
alias dj='python manage.py'
alias mm='python manage.py makemigrations'
alias mi='python manage.py migrate'
alias rs='python manage.py runserver'
alias fs='python manage.py flush'
alias csu='python manage.py createsuperuser'
#-------------------------------------------------------------------------------------------END OF ALIAS-------------------------------------------------------------------------------------#
#                                                                                                                                                                                            #
#                                                                                                                                                                                            #
#--------------------------------------------------------------------------------------USER DEFINED FUNCTIONS--------------------------------------------------------------------------------#
#Java Compiler
jc () {
  javac "$1".java
  echo "Compiled"
  ./"$1".class
}
#C Compile and execute
cc () {
  gcc "$1".c -o "$1"
  echo "Compiled"
  ./"$1"
}
#Webm Convertor
webm (){
  if [ $# -ne 2 ]; then
    echo "Example usage: webm input.mp4 1920"
    return
  fi

  FILENAME=${1%%.*}
  mkdir webm

  ffmpeg -i $1 -c:v libvpx-vp9 -crf 40 -vf scale=$2:-2 -an webm/${FILENAME}.webm
  ffmpeg -i $1 -c:v libx264 -crf 24 -vf scale=$2:-2 -movflags faststart -an webm/${FILENAME}_h264.mp4
  ffmpeg -i $1 -c:v libx265 -crf 28 -vf scale=$2:-2 -tag:v hvc1 -movflags faststart -an webm/${FILENAME}_h265.mp4
}

#Webp Convertor
webp (){
  if [ $# -ne 1 ]; then
    echo "Example usage: webp filename.png"
    return
  fi

  FILENAME=${1%%.*}
  ffmpeg -i $1 -c libwebp ${FILENAME}.webp
}

#Youtube Downloader
#Video
yt (){
  if [ $# -ne 1 ]; then
    echo "Example usage: yt 'YouTube URL' "
    return
  fi

  yt-dlp --ignore-config -o "~/Videos/Youtube/%(channel)s/%(title)s.%(ext)s" $1 --embed-subs
}
#Playlists
ytp (){
  if [ $# -ne 1 ]; then
    echo "Example usage: ytp 'YouTube URL' "
    return
  fi

  yt-dlp --ignore-config -o "~/Videos/Youtube/%(channel)s/%(playlist_title)s/%(title)s.%(ext)s" $1 --embed-subs --yes-playlist
}
#Music
ytm (){
  if [ $# -ne 1 ]; then
    echo "Example usage: yt 'YouTube URL' "
    return
  fi

  yt-dlp --ignore-config -o "~/Music/%(playlist_title)s/%(title)s.%(ext)s" $1 --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --yes-playlist --embed-thumbnail --embed-metadata
}

#Github Repository Initializer
gint () {
  mkdir ~/Projects/$1
  cd ~/Projects/$1
  touch .gitignore
  git init
  git add .
  git commit -m "Repository Initialization 😀"
  gh repo create $1 --public
  git remote add origin git@github.com:vasanth064/$1.git
  git push -u origin main
  code .
  exit
}

#C# Compile and Runner
cs () {
  mcs "$1".cs
  echo 'Compiled'
  ./"$1".exe
}
#React App Initializer
cra () { 
  if [ $1 ne . ]; then
  name=$1
  cd ~/Projects/ && yarn create react-app "$name" && cd "$name" && code . && exit
  return
  fi
  name=$1
  yarn create react-app "$name" && cd "$name" && code . && exit
}

#ZSHRC Editor 
zshrc () {
  nano ~/.zshrc
  source ~/.zshrc
  clear
}

#VS Code Opener
vs () {
  code .
  exit
}

#Projects Folder Opener
dev () {
  cd ~/Projects
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#																							     #
#																							     #
#----------------------------------------------------------------------------------END OF USER DEFINED FUNCTIONS-----------------------------------------------------------------------------#
#ZSH DEFAULTS
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle :compinstall filename '/home/vasanth/.zshrc'
autoload -Uz compinit
compinit

#ZSH PLUGINS

#Syntax Highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#Auto Suggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#Notifier
source ~/.config/zsh/zsh-auto-notify/auto-notify.plugin.zsh
#Use Should Use
source ~/.config/zsh/zsh-you-should-use/you-should-use.plugin.zsh
#History Search
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/.local/share/bin/"

#Starship Prompt
eval "$(starship init zsh)"
