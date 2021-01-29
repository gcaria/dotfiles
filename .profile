alias py='python'
alias ipy='ipython'

alias path="readlink -f"
alias l='ls -lha'

alias nbr="jupyter notebook --no-browser --port=8887"

alias fixstyle="autopep8 --in-place --ignore E24 -v"

# Vim
alias vi='vim'
alias vp='vim +PluginInstall +qall'
alias vc='vim +BundleClean +qall'

# Jobs
alias qs='qstat -u gcaria'
alias wqs='watch -n 1 qstat -u gcaria'
alias wss="watch -n 1 $NC/scripts/jobs/summaryJobs"
alias killa='qselect -u gcaria | xargs qdel'

# Git
alias remdel='git ls-files --deleted -z | xargs -0 git rm'
alias fb="python $NC/scripts/misc/fast_backup.py"

# Screen
alias sc="screen"
alias sls="screen -ls"
alias sr="screen -r"

# Zsh configuration
alias ez="vi ~/.zshrc"
alias ep="vi ~/.profile"
alias ev="vi ~/.vimrc"
alias sz="source ~/.zshrc"

# Pager
# alias vv="vimpager"
# alias less=$PAGER
# alias zless=$PAGER
alias space="du -h --max-depth=1"
alias ungz="tar -xzf"

alias pc="python $NC/scripts/radiative/print_conditions"
alias sv="python $NC/scripts/misc/show_vars.py"
alias svt="sv /bdd/ARA/GEWEX_CA_ftp/TRMM/2005/3A-ORBIT.TRMM.PR.TRMM-SLH.20050702-S091454-E104716.043477.V06A.HDF5"

alias config='$LI/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function hgt() {
    if [ -z "$2" ]
    then
        history | grep "$1" | tail -n 10
    else
        history | grep "$1" | tail -n "$2"
    fi
}
alias hg="hgt"

function sk() {
    screen -X -S "$1" quit	
}


function rrr() {
    rpm2cpio "$1" | cpio -id
}
