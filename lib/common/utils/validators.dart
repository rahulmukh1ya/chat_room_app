class Validators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty.';
    } else if (value.length < 3) {
      return 'Name too short.';
    } else {
      return null;
    }
  }

  static String? validateRoomName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Room Name cannot be empty.';
    } else if (value.length < 3) {
      return 'Room Name too short.';
    } else {
      return null;
    }
  }

  static String? validateRoomID(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID cannot be empty.';
    } else if (!RegExp(r'^[A-Z0-9]{8}$').hasMatch(value)) {
      return 'ID should be 8 characters long.';
    } else {
      return null;
    }
  }

  static String? validateRoomPIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN cannot be empty.';
    } else if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'PIN should be exactly 6 digits.';
    } else {
      return null;
    }
  }

  //   bool isValidPIN(String pin) {
  //   final regex = RegExp(r'^[0-9]{6}$');
  //   return regex.hasMatch(pin);
  // }

  // bool isValidID(String id) {
  //   final regex = RegExp(r'^[A-Z0-9]{8}$');
  //   return regex.hasMatch(id);
  // }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password too short';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
    String? value, {
    required String password,
  }) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty.';
    } else if (value != password) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }
}
