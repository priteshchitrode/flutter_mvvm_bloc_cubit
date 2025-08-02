
class Validator {
  Validator._();

  /// Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Field Required
  static String? fieldRequired(String? value, {String? fieldName}){
    if (value == null || value.isEmpty) {
      if(fieldName != null){
        return '$fieldName is required';
      }else{
        return 'This filed is required';
      }
    }
    return null;
  }

  /// Password
  static String? password(String? value){
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if(value.length < 6){
      return "Password must be at least 6 character long.";
    }
    return null;
  }

  static String? phone(String? value) {
    String pattern = r'^\+?[0-9]+$';
    RegExp regExp = RegExp(pattern);
    const int minLength = 10;
    const int maxLength = 10;

    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid mobile number';
    } else if (value.length < minLength || value.length > maxLength) {
      return 'Mobile number must be $maxLength digits';
    }
    return null;
  }


  static String? countryCode(String? value) {
    String pattern = r'^\+\d{1,3}$';  // Pattern for '+' followed by 1 to 3 digits
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter country code';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid country code';
    }
    return null;
  }



}
