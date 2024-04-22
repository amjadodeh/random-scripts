
# random-scripts

some random scripts. 

## [Weekly Assignment Scheduler](https://github.com/amjadodeh/random-scripts/tree/master/weekly-assignment-scheduler)

This Bash script randomly assigns places to people throughout the week, making it perfect for setting up unpredictable audits or inspections where randomization is crucial.

Each place in `places.txt` is assigned only once each day. Each person in `people.txt` is assigned only one day of the week unless all have already been assigned once, after which the first person `people.txt` is reused.

### Setup and Usage

**Edit Input Files**:
   - Modify `people.txt` and `places.txt` to list names one per line as per your requirements.


**Run the Script**:
   - Ensure the script is executable: `chmod +x assigner.sh`.
   - Run the script by executing `./assigner.sh` in your terminal. When prompted, enter the number of times each place should be assigned per week.

### Output

The script generates a weekly chart that randomly assigns people to places for each day. It indicates any days without assignments as "No assignments".

### Ideal Use Cases

This tool is particularly useful for environments needing stringent random checks, such as conducting random audits in businesses, health inspections in facilities, or environmental compliance checks. The random assignment ensures that these tasks are not predictable.

## Custom keyd Setup

Moved to [arabic-transliteration-keyd-setup](https://github.com/amjadodeh/arabic-transliteration-keyd-setup)

