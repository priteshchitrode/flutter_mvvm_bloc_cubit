@override
class AppString {
  AppString._();
  static AppLabelText label = AppLabelText();
  static AppErrorText error = AppErrorText();
  static ErrorTypeMsg errorType = ErrorTypeMsg();
  static PreferenceKey sessionKey = PreferenceKey();
  static AppAlertText alert = AppAlertText();
  static AppSuccessText success = AppSuccessText();
}

class AppLabelText {
  // Core
  final String appName = "Update Your AppName";
  final String submit = "Submit";
  final String refresh = "Refresh";
  final String attachment = "Attachment";
  final String documents = "Documents";
  final String docSupport = "*Only support .jpg, .png & .heic files not more than 5 mb.";
  final String imageSupport = "*Only support .jpg, .png & .heic";
  final String imageSize = "Image size should be less than 8MB";
  final String chooseFile = "Choose File";
  final String selectDate = "Select Date";
  final String selectTime = "Select Time";
  final String selectHour = "Select Hour";
  final String date = "Date";
  final String time = "Time";
  final String hour = "Hour";
  final String from = "From";
  final String to = "To";
  final String yes = "Yes";
  final String no = "No";
  final String loading = "Loading...";
  final String addMore = "Add More";
  final String addMoreOption = "Add More Option";
  final String fromCamera = "Camera";
  final String fromGallery = "Gallery";
  final String selectImageFrom = "Select image from?";
  final String name = "Name";
  final String back = "Go Back";
  final String cancel = "Cancel";
  final String logout = 'Logout';
  final String noImageSelected = 'No image selected';
  final String noResultFor = 'No Results for';
  final String notification = 'Notification';
  final String backToHome = 'Back to home';
  final String checkSpellingSearch = 'Check the spelling or try a new search.';


  // App String


}

class AppErrorText {
  final String noInternetConnection = "No internet connection";
  final String somethingWentWrong = 'Something Went Wrong';
  final String thisFieldRequired = 'This field is required';
  final String pleaseEnterAmount = 'Please enter amount';
  final String internetNotAvailable = 'Your internet is not working';
  final String duringCommunication = 'Error During Communication';
  final String invalidRequest = 'Invalid Request';
  final String unauthorisedException = 'Unauthorised Exception';
  final String invalidInputException = 'Invalid Input Exception';
  final String communicatingWithServer = 'Error occur while communicating with server, Try again later.';
  final String noInput = 'No input, Input field is required.';
  final String failedToFetchData = 'Failed to fetch data';
  final String noDataFound = 'No data found, Please try again later.';
  final String failToFetchResponse = 'Failed to fetch response';
  final String deserializationError = 'Deserialization error';
  final String invalidPhoneNumber = 'Invalid phone number';
  final String contactPermissionDenied = 'Contact Permission Denied';
  final String failToDownloadFile = 'Error downloading file';
}

class AppAlertText {
  final String otpMustBeSixDigit = "OTP must be six digit";
  final String pleaseSelectGuest =  "Please select guest";
  final String contactPermissionDenied =  "Permission denied to add contacts.";
  final String loginIDAndPasswordIsRequired =  "Login ID & Password is required";
  final String pollOptionAlert =  "You can select a maximum of 5 options only.";
}

class AppSuccessText {
  final String guestCreatedSuccessfully = "Guest visit created successfully.";
  final String cabCreatedSuccessfully = "Cab visitor created successfully.";
  final String deliveryCreatedSuccessfully = "Delivery visitor created successfully.";
  final String visitingHelpVisitorCreatedSuccessfully = "Visiting help visitor created successfully.";
  final String requestAddedSuccessfully = "Request added successfully";
}

class ErrorTypeMsg {
  final String somethingWentWrong = "Sorry, Something went wrong.";
  final String responseStatusFail = "Response Status Fail";
  final String loginAttemptError = "Login attempt unsuccessful, Please try again later";
  final String noInternetConnection = "No internet connection.";
  final String networkError = "Your internet not working,\nPlease try again later.";
  final String notFound = "No record found, Please try again later.";
  final String genericError = "Something went wrong!!";
  final String conflictError = "Oops! It seems there's a conflict";
  final String deserializationError = "Oops! Deserialization Error,\nSomething went wrong while loading the data."; // Deserialization (JSON/String → Object)
  final String serializationError = "Oops! Serialization Error,\nSomething went wrong while loading the data."; // Serialization (Object → JSON/String)
  final String invalidTokenError = "Authentication Failed, Invalid Token.";
  final String tokenExpireError = "Authentication Failed, Login Session Expired.";
  final String unauthenticatedError = "Authentication Required";
  final String badRequestError = "Bad Request: Something went wrong with your request";
  final String invalidInput = "Oops! Invalid Input,\nPlease check your entry and try again.";
  final String timeOutError = "Oops! Time out!!,\nPlease check your entry and try again.";
  final String requestCancelledError = "Request Cancelled, \nPlease check your entry and try again.";
  final String internalServerError = "Internal Server Error, Please try again later.";

}

class PreferenceKey {
  final String uid = "uid";
  final String userToken = "idToken";
  final String userId = "userId";
  final String refreshToken = "refreshToken";
  final String firstName = "firstName";
  final String lastName = "lastName";
  final String fcmToken = "fcmToken";
  final String userAddress = "userAddress";
  final String userFullName = "userFullName";
  final String userType = "userType";
  final String userProfilePhoto = "userProfilePhoto";
  final String rememberMe = "rememberMe";
}
