class Validators {
  static final _instance = Validators._internal();
  factory Validators() => _instance;
  Validators._internal();

  String emptyFieldCheck(String value, String message) {
    if (value?.isEmpty ?? true) {
      return message;
    }
    return null;
  }

  String validateEmail(String value, {bool optional = false}) {
    var message = "Email is required";
    if (value.isEmpty) {
      if (optional) {
        return null;
      }
      message = message;
    } else {
      // Regex condition and messages
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!emailValid) {
        message = "Valid email is required";
      } else {
        return null;
      }
    }
    return message;
  }

  String required(String value) {
    var message = "Required";
    if (value.isEmpty || value == null) {
      message = message;
    } else {
      return null;
    }
    return message;
  }

  String validatePassword(String value) {
    var message = "Password is required";
    if (value.isEmpty || value == null) {
      message = message;
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  lengthValidator(String value, List<int> length) {
    bool result = false;
    for (int i = 0; i < length.length; i++) {
      if (value.length == length[i]) {
        result = true;
      }
    }
    return result;
  }

  String validateLoginID(String value) {
    var message = "Login ID is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.length < 3 || value.length > 16) {
      message = "Please enter valid login id.";
    } else {
      return null;
    }
    return message;
  }

  String validateMobileNumber(String value) {
    var message = "Mobile number is required";
    if (value.isEmpty) {
      message = message;
    } else if (value.contains(r'[.-]') || value.length < 11) {
      message = "Valid mobile number is required";
    } else {
      // Regex condition and messages
      return null;
    }
    return message;
  }

  String validUsername(String value) {
    final alphabet = RegExp(r'^[a-zA-Z]+$');

    if (value == null || value.isEmpty) {
      return 'Username is required';
    } else if (!alphabet.hasMatch(value[0])) {
      return 'Invalid username';
    }
  }

  String validateConfirmPassword(
      String passwordOnFocus, String passwordInComparison) {
    String message = validatePassword(passwordOnFocus);
    if (passwordInComparison.isEmpty) return message;
    if (message == null && passwordOnFocus != passwordInComparison) {
      message = 'Passwords are not same';
    }
    return message;
  }
}
