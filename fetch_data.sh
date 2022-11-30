rm -rf data
wget https://github.com/arthur-schnitzler/pollaczek-data/archive/refs/heads/main.zip
unzip main.zip && rm main.zip
mv pollaczek-data-main/data ./data
rm -rf pollaczek-data-main
./dl_imprint.sh