add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at.at/pollaczek"
add-attributes -g "./data/meta/*.xml" -b "https://id.acdh.oeaw.ac.at.at/pollaczek"
add-attributes -g "./data/indices/*.xml" -b "https://id.acdh.oeaw.ac.at.at/pollaczek"

echo "make calendar data"
python make_calendar_data.py