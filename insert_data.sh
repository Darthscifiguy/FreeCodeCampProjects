#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#Script to insert data into worldcup DB
echo -e "\n~~INSERT WORLDCUP DATA UTILITY~~\n"

#clear out data for fresh opertions
CLEAR_DB=$($PSQL "TRUNCATE TABLE games, teams")

#teams data insertion
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    #Test for loop
    #echo -e "\n $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS"

    #Check for duplicates per match
    CHECK_NAMES_WINNER=$($PSQL "SELECT name FROM teams where name='$WINNER'")
    CHECK_NAMES_OPPONENT=$($PSQL "SELECT name FROM teams where name='$OPPONENT'")

    #Check for top row (possibly make more efficient)
    if [[ -z $CHECK_NAMES_WINNER && $WINNER != winner ]]
    then
        #Insert team data
        INSERT_NAMES=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
        echo -e "\nInserted $WINNER into teams table"
    fi

    if [[ -z $CHECK_NAMES_OPPONENT && $OPPONENT != opponent ]]
    then
        #Insert team data
        INSERT_NAMES=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
        echo -e "\nInserted $OPPONENT into teams table"
    fi
  done

#Games data insertion
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    #match foriegn keys
    WINNER_INFO=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
    OPPONENT_INFO=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
    
    #Check for top row
    if [[ $YEAR != year ]]
    then
        #insert game data
        INSERT_GAME_DATA=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_INFO, $OPPONENT_INFO, $WINNER_GOALS, $OPPONENT_GOALS)")
        echo -e "\n Inserted $YEAR AND $ROUND into games"
    fi
  done
