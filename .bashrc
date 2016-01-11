# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

more_confs=( .bashrc_cust .bashrc_git .bashrc_tmux )
for conf in "${more_confs[@]}"
do
   if [ -f ~/"$conf" ]; then
      . ~/"$conf"
   fi
done
