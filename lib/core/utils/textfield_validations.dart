class Validations {
  static String? validateName(val) {
    final RegExp regex = RegExp(r'^[a-zA-Z]+$');
    if (val!.isEmpty) {
      return 'Please enter firstname';
    } else if (!regex.hasMatch(val)) {
      return 'Please enter valid firstname';
    } else {
      return null;
    }
  }

  static String? validateUser(val) {
    final RegExp regex = RegExp(r'^[a-zA-Z]+$');
    if (val!.isEmpty) {
      return 'Please enter Field';
    } else if (!regex.hasMatch(val)) {
      return 'Please enter valid firstname';
    } else {
      return null;
    }
  }

  static String? validateEmail(val) {
    if (val.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePhoneNumber(val) {
    if (val!.isEmpty) {
      return 'Please enter your phone number';
    } else if (val.length != 10) {
      return 'Please enter valid phone number';
    } else {
      return null;
    }
  }

  static String? validatePassword(val) {
    if (val!.isEmpty) {
      return 'Please enter your password';
    } else {
      return null;
    }
  }
}
