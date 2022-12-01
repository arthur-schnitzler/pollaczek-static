# Clara Katharina Pollaczek – Arthur Schnitzler und ich
[![Build and publish](https://github.com/arthur-schnitzler/pollaczek-static/actions/workflows/build.yml/badge.svg)](https://github.com/arthur-schnitzler/pollaczek-static/actions/workflows/build.yml)

## install

[one time]
* clone the repo
* run `script.sh` to download and install needed things
* run `pip install -r requirements.txt` (ideally in a previously created virtual environment)

### fetch and process the data

[on data changes]
* the appliation's data is located in [pollaczek-data](https://github.com/arthur-schnitzler/pollaczek-data); run `./fetch_data.sh` to copy and extract needed data
* run `./process.sh` to add e.g. `@xml:id` `@next` and `@prev` attributes into the documents and to populate the calendar-data
* [optional] run `python make_typensense_index.py` to populate the fulltext search index, only works if needed environment variables are set


* build with [DSE-Static-Cookiecutter](https://github.com/acdh-oeaw/dse-static-cookiecutter)
