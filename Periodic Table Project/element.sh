#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only --no-align -c"


if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]*$ ]]
  then
    AN_TEST=$($PSQL "Select type_id from properties where atomic_number=$1;")
    if [[ $AN_TEST ]]
      then
        ELEMENT_ATOMIC_NUMBER=$($PSQL "Select atomic_number from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_NAME=$($PSQL "Select name from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_SYMBOL=$($PSQL "Select symbol from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_TYPE=$($PSQL "Select type from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_ATOMIC_MASS=$($PSQL "Select atomic_mass from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_MELTING_POINT=$($PSQL "Select melting_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        ELEMENT_BOILING_POINT=$($PSQL "Select boiling_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where atomic_number=$1;")
        echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    else
      echo "I could not find that element in the database."
    fi
  elif [[ $1 =~ [^0-9] ]]
    then
      NAME_TEST=$($PSQL "Select type_id from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
      SYMBOL_TEST=$($PSQL "Select type_id from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")

      if [[ $NAME_TEST ]]
        then
          ELEMENT_ATOMIC_NUMBER=$($PSQL "Select atomic_number from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_NAME=$($PSQL "Select name from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_SYMBOL=$($PSQL "Select symbol from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_TYPE=$($PSQL "Select type from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_ATOMIC_MASS=$($PSQL "Select atomic_mass from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_MELTING_POINT=$($PSQL "Select melting_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          ELEMENT_BOILING_POINT=$($PSQL "Select boiling_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where name='$1';")
          echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
      elif [[ $SYMBOL_TEST ]]
        then
          ELEMENT_ATOMIC_NUMBER=$($PSQL "Select atomic_number from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_NAME=$($PSQL "Select name from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_SYMBOL=$($PSQL "Select symbol from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_TYPE=$($PSQL "Select type from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_ATOMIC_MASS=$($PSQL "Select atomic_mass from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_MELTING_POINT=$($PSQL "Select melting_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          ELEMENT_BOILING_POINT=$($PSQL "Select boiling_point_celsius from properties inner join elements using (atomic_number) inner join types using (type_id) where symbol='$1';")
          echo "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
      else
        echo "I could not find that element in the database."
      fi
  fi
else
  echo "Please provide an element as an argument."
fi


