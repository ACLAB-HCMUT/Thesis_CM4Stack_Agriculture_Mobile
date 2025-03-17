// class TValidator {
//   static String? validateEmptyText(String? fieldName, String? value) {
//     if (value == null || value.isEmpty||value=='') {
//       return '$fieldName is required.';
//     }
//     return null;
//   }
//
//   static String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email is required.';
//     }
//
//     //? Regular expression for email validation
//     final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//
//     if (!emailRegExp.hasMatch(value)) {
//       return 'Invalid email address.';
//     }
//
//     return null;
//   }
//
//   static String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required.';
//     }
//
//     //? Check for minimum password length
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters long.';
//     }
//
//     //? Check for uppercase letters
//     if (!value.contains(RegExp(r'[A-Z]'))) {
//       return 'Password must contain at least one uppercase letter.';
//     }
//
//     //? Check for numbers
//     if (!value.contains(RegExp(r'[0-9]'))) {
//       return 'Password must contain at least one number.';
//     }
//
//     //? Check for special characters
//     if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//       return 'Password must contain at least one special character.';
//     }
//
//     return null;
//   }
//
//   static String? validatePhoneNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number is required.';
//     }
//
//     //? Regular expression for phone number validation (assuming a 10-digit US phone number format)
//     final phoneRegExp = RegExp(r'^\d{10}$');
//
//     if (!phoneRegExp.hasMatch(value)) {
//       return 'Invalid phone number format (10 digits required).';
//     }
//
//     return null;
//   }
//
// //? Add more custom validators as needed for your specific requirements.
// }
class TValidator {
  /// Validates that a text field is not empty
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty||value=='') {
      return '$fieldName is required.';
    }
    return null;
  }

  /// Validates an email address format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  /// Validates password complexity (length, uppercase, number, special character)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  /// Validates a phone number format (10 digits)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  /// Validates that a date is selected (non-empty)
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty||value=='') {
      return 'Date is required.';
    }
    return null;
  }

  /// Validates that a category is selected from dropdown (non-empty)
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category.';
    }
    return null;
  }

  /// Validates dropdown or multi-select lists
  static String? validateDropdownSelection(String? fieldName, List<String> values) {
    if (values.isEmpty) {
      return 'Please select at least one $fieldName.';
    }
    return null;
  }

// Additional custom validators can be added as needed
}
