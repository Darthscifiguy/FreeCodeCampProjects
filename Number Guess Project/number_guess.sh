#!/bin/bash

#Script that allows users to play the number guessing game.

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

GUESS_ANALYZER()
{
  #Uptick guess
  (( NUMBER_OF_GUESSES++ ))

  #Check if input is an integer
   if [[ $1 =~ [^0-9] ]]
   then
    echo -e "\nThat is not an integer, guess again:"
    read NUMBER_GUESS
    GUESS_ANALYZER $NUMBER_GUESS $2
  #Logic for determining response to guess
  elif [[ $1 -gt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"
      read NUMBER_GUESS
      GUESS_ANALYZER $NUMBER_GUESS $2
  elif [[ $1 -lt $RANDOM_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"
      read NUMBER_GUESS
      GUESS_ANALYZER $NUMBER_GUESS $2
  elif [[ $1 -eq $RANDOM_NUMBER  ]]
    then
    #Uptick games played in DB
    BEST_GAME_INFO=$($PSQL "SELECT best_game from users where username='$2'")
    if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME_INFO || $BEST_GAME_INFO -eq 0 ]]
    then
      GAME_STATS=$($PSQL "UPDATE users set games_played=games_played+1, best_game=$NUMBER_OF_GUESSES where username='$2'")
    else
      GAME_STATS=$($PSQL "UPDATE users set games_played=games_played+1 where username='$2'")
    fi
    echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
  fi
}

#Read username
echo -e "\nEnter your username:"
read USERNAME

#Check to see if username is already in DB and output info
USERNAME_CHECK=$($PSQL "SELECT username from users where username='$USERNAME'")
if [[ $USERNAME_CHECK ]]
then
  GAMES_PLAYED=$($PSQL "SELECT games_played from users where username='$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game from users where username='$USERNAME'")
  echo "Welcome back, $USERNAME_CHECK! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
else
  #Add new user
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  NEW_USER=$($PSQL "INSERT INTO users(username, games_played, best_game) VALUES ('$USERNAME', 0, 0)")
fi

#First guess msg
echo -e "\nGuess the secret number between 1 and 1000:"
read NUMBER_GUESS

GUESS_ANALYZER $NUMBER_GUESS $USERNAME


