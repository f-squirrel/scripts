
#TODO: Consider installing it via VimPlug
cd
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# To search for hidden files
echo "export FZF_DEFAULT_COMMAND='find .'" >> ${HOME}/.zshrc

printf "Finished building tools!\n"
