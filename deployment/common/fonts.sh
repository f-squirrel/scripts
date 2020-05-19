#Powerline for some reason works better when installed manually

cd
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

printf "Finished font setup\n"
