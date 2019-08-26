# Peachly-Mobile-Developer-Take-Home-Exercise
This app is a simple Feedback form.

## How to use:
The user must enter their first name, last name, an email address, and a maximum 500 character message in order to submit the form. All inputs are required, and the email input is required to be in a valid email format.

## How to it works:
- The app loads with four input boxes with placeholders and a submit button. Using viewDidLoad() I hide all error messages, create the message count and message placeholder by setting the message UITextView delegate. 
- Using two textView delegate methods, textViewDidBeginEditing() and textViewDidEndEditing(), I specifiy how the message placeholder disappears and reappears depending when the user is typing. 
- TextView() delegate method: implement the message character count. 
- validEmail(): Email validation method which compares the users inputed email to the specified regular expression. If the inputed email matches this it returns true, otherwise false. 
- submit(): checks whether or not the input fields have been properly filled in and the email is valid. If a field is missing an error message appears below the input field notifying the user that the input is required or that their email was inputted incorrectly. 
- Upon pressing the submit button a POST request is sent. After the session is completed there is a response from the server printed in the consule, that prints whether or not each input, the first name, last name, email and message, are valid. 

