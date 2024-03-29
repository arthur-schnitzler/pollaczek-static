rm -rf data
curl -LO https://github.com/arthur-schnitzler/pollaczek-data/archive/refs/heads/main.zip
unzip main.zip && rm main.zip
mv pollaczek-data-main/data ./data
mv pollaczek-data-main/bibliografie/listBibl.xml ./data
mv pollaczek-data-main/bibliografie/bibliografie.xml ./data
mv pollaczek-data-main/data/meta/CP-aufsatz.xml ./data/meta
rm -rf pollaczek-data-main
./dl_imprint.sh