#!/bin/bash

#Script to display menu to schedule an appointment at the salon

echo -e "\n~~Everybody's Salon~~\n"

echo -e "Welcome to Everybody's Salon!\n"

#Global Vars
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
GLOBAL_READER=""
CUSTOMER_NAME=""
CUSTOMER_ID=-1
SELECTED_SERVICE=""
SERVICE_ID_SELECTED=""
IS_FINISHED=0

SERVICE_MENU()
{
  #Recovery section
  if [[ $1 ]]
  then
      echo -e "\n$1"
  fi

  #Display the menu
  echo -e "\nWhat Service would you like to schedule?"
  echo -e "\n1) Haircut"
  echo -e "\n2) Beard Trim"
  echo -e "\n3) Moustashe Styling"
  echo -e "\n4) Perm"
  echo -e "\n5) Pedicure"
  echo -e "\n6) Manicure"
  echo -e "\n7) Color"
  read SERVICE_ID_SELECTED
}

PHONE_CHECK()
{
  #Asks for phone number
  echo -e "\nWhat is your phone number:"
  read CUSTOMER_PHONE

  #Gets name otherwise assume new customer and add into system
  CUSTOMER_NAME=$($PSQL "Select name from customers where phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
    then
      echo -e "\nYour phone number is not on file. Please, enter your name:"
      read CUSTOMER_NAME
      NEW_CUSTOMER=$($PSQL "Insert into customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  #Set customer id and service
  CUSTOMER_ID=$($PSQL "Select customer_id from customers where phone='$CUSTOMER_PHONE'")
  SELECTED_SERVICE=$($PSQL "Select name from services where service_id='$SERVICE_ID_SELECTED'")
}


while [ $IS_FINISHED -lt 3 ]
do
  #Service Menu check
  if [[ $IS_FINISHED == 2 ]]
  then
    SERVICE_MENU "Please input a number that corresponds with an ID."
  else
    SERVICE_MENU
  fi

  if [[ "$SERVICE_ID_SELECTED" == "1" ]]
    then
      #Function call to check phone number
      PHONE_CHECK

      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "2" ]]
    then 
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "3" ]]
    then
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "4" ]]
    then
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME
      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "5" ]]
    then
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "6" ]]
    then
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  elif [[ "$SERVICE_ID_SELECTED" == "7" ]]
    then
      #Function call to check phone number
      PHONE_CHECK
      
      #Ask for time
      echo -e "\nWhat time would you like for your$SELECTED_SERVICE?"
      read SERVICE_TIME

      #Insert appointment info into the table
      APPOINTMENT_TIME=$($PSQL "Insert into appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

      #Comfirmation message
      echo -e "\nI have put you down for a$SELECTED_SERVICE at $SERVICE_TIME,$CUSTOMER_NAME."
      IS_FINISHED=3
  else
  #Input error check
    IS_FINISHED=2
  fi

done
