rm -rf data
wget https://github.com/arthur-schnitzler/pollaczek/archive/refs/heads/main.zip
unzip main.zip && rm main.zip
mv pollaczek-main/data ./data
rm -rf pollaczek-main
./dl_imprint.sh