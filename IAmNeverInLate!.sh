#!/bin/sh -e

# tchenier - Reason late test, refound of smack-my-bitch-up
# Exit early if no sessions with my username are found
if ! who | grep -wq $USER; then
  exit
fi

# Phone numbers
MY_NUMBER='+xxx'
HER_NUMBER='+xxx'

REASONS=(
  'My dog eat my key cars.'
  'I have a gastro.'
  'The matrix has me.'
)
rand=$[ $RANDOM % ${#REASONS[@]} ]

RANDOM_REASON=${REASONS[$rand]}
MESSAGE="Late at work: "$RANDOM_REASON

# Send a text message with twilio :)
RESPONSE=`curl -fSs -u "$TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN" \
  -d "From=$MY_NUMBER" -d "To=$HER_NUMBER" -d "Body=$MESSAGE" \
  "https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages"`

# Log errors
if [ $? -gt 0 ]; then
  echo "Failed to send SMS: $RESPONSE"
  exit 1
fi