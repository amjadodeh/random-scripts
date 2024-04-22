#!/usr/bin/env bash

# Prompt the user for the number of repetitions each place should have
read -p "Enter the number of repetitions for each place per week: " place_repetition
echo

# Check for numeric input
if ! [[ "$place_repetition" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number."
    exit 1
fi

# Read people and places from files
readarray -t people < people.txt
readarray -t places < places.txt

# Days of the week
days=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday")

# Initialize associative arrays for storing place and people assignments
declare -A day_places
declare -A day_people
declare -A place_count

# Initialize place counts
for place in "${places[@]}"; do
    place_count["$place"]=0
done

# List to track already assigned people
assigned_people=()

# Function to get the next person not yet assigned
next_person() {
  for person in "${people[@]}"; do
    if [[ ! " ${assigned_people[*]} " =~ "${person}" ]]; then
      echo "$person"
      return
    fi
  done
  # If all are assigned, reset and start from first person again
  assigned_people=()
  echo "${people[0]}"
}

# Assign places to days, trying to balance out the distribution
assign_places() {
  while true; do
    local changes_made=false
    for place in "${places[@]}"; do
      while [ "${place_count["$place"]}" -lt "$place_repetition" ]; do
        local possible_days=()
        for day in "${days[@]}"; do
          # Check if the place is already on this day
          if [[ ! "${day_places[$day]}" =~ "$place" ]]; then
            possible_days+=("$day")
          fi
        done
        # Continue only if there are possible days to assign
        if [ ${#possible_days[@]} -eq 0 ]; then
          continue
        fi
        local selected_day=${possible_days[$RANDOM % ${#possible_days[@]}]}
        if [ -z "${day_places[$selected_day]}" ]; then
          day_places[$selected_day]="- $place"
        else
          day_places[$selected_day]+="$(echo -e "\n  - $place")"
        fi
        ((place_count["$place"]++))
        changes_made=true
      done
    done
    if ! $changes_made; then break; fi  # Break if no changes were made in the last iteration
  done
}

# Attempt to assign places
assign_places

# Assign exactly one person to each day that has a place
for day in "${days[@]}"; do
  if [ -n "${day_places[$day]}" ]; then
    person=$(next_person)
    day_people[$day]="$person"
    assigned_people+=("$person")
  fi
done

# Output the weekly assignment chart
echo "Weekly Assignment Chart"
echo "========================"
for day in "${days[@]}"; do
  echo "$day:"
  if [ -n "${day_people[$day]}" ]; then
    echo "  ${day_people[$day]}"
    echo "  ${day_places[$day]}"
  else
    echo "  No assignments"
  fi
  echo "------------------------"
done

