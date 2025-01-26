import 'package:easy_localization/easy_localization.dart';

class HelperFunctions {
  static String? validateEmail(String? value) {
    final emailRegEx = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (value == null || value.isEmpty) {
      return 'Email is required'.tr();
    } else if (!emailRegEx.hasMatch(value)) {
      return 'Invalid email format'.tr();
    } else if (value.length > 254) {
      return 'Email must not exceed 254 characters'.tr();
    }
    return null;
  }

  static String? validateName(String? value, String field) {
    final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$');
    if (value == null || value.isEmpty) {
      return "${field.tr()} ${"is required".tr()}";
    } else if (value.length < 10) {
      return "${field.tr()} ${"must be at least 10 characters".tr()}";
    } else if (value.length > 100) {
      return "${field.tr()} ${"must not exceed 35 characters".tr()}";
    }
    return null;
  }

  static String? validateRegisterName(String? value, String field) {
    final RegExp onlyLetters = RegExp(r'^[a-zA-Z\s]+$');
    if (value == null || value.isEmpty) {
      return "${field.tr()} ${"is required".tr()}";
    } else if (value.length < 2) {
      return "${field.tr()} ${"must be at least 2 characters".tr()}";
    } else if (value.length > 100) {
      return "${field.tr()} ${"must not exceed 35 characters".tr()}";
    }
    return null;
  }

  static String? validateProductName(String? productName) {
    if (productName == null || productName.isEmpty) {
      return 'Product name cannot be empty'.tr();
    }
    if (productName.length < 5) {
      return 'Product name must be at least 5 characters long'.tr();
    }
    if (productName.length > 150) {
      return 'Product name must be no more than 150 characters long'.tr();
    }
    return null; // Product name is valid
  }

  static String? validateQuantity(String? quantity) {
    if (quantity == null || quantity.isEmpty) {
      return 'Quantity cannot be empty'.tr();
    }
    final int? value = int.tryParse(quantity);
    if (value == null || value <= 0) {
      return 'Quantity must be greater than 0'.tr();
    }

    return null; // Quantity is valid
  }

  static String? validatePhoneNumber(String countryCode, String phoneNumber) {
    final Map<String, RegExp> patterns = {
      '+20': RegExp(r'^(010|011|012|015)\d{8}$'), // Egypt
      '+966': RegExp(r'^5\d{8}$'), // Saudi Arabia
      '+973': RegExp(r'^3\d{7}$'), // Bahrain
    };
    if (!patterns.containsKey(countryCode)) {
      return 'Unsupported country code'.tr();
    }
    final RegExp pattern = patterns[countryCode]!;
    if (!pattern.hasMatch(phoneNumber)) {
      return "${"Invalid phone number for".tr()}$countryCode";
    }
    return null; // Valid phone number
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name is required'.tr();
    } else if (value.length < 2) {
      return 'Company name must be at least 2 characters'.tr();
    } else if (value.length > 100) {
      return 'Company name must not exceed 100 characters'.tr();
    }
    return null;
  }

  static String? validateJobTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Job Title is required'.tr();
    }
    return null;
  }

  static String? validateFieldRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required'.tr();
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty'.tr();
    }
    if (value.length > 300) {
      return 'Value cannot be greater than 300'.tr();
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty'.tr();
    }

    // Check minimum length
    if (password.length < 8) {
      return 'Password must be at least 8 characters long'.tr();
    }

    // Check for a mix of uppercase and lowercase letters
    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    if (!hasUppercase.hasMatch(password) || !hasLowercase.hasMatch(password)) {
      return 'Password must include both uppercase and lowercase letters';
    }

    // Check for numbers
    final RegExp hasNumber = RegExp(r'\d');
    if (!hasNumber.hasMatch(password)) {
      return 'Password must include at least one number';
    }

    // Check for special characters
    final RegExp hasSpecialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!hasSpecialCharacter.hasMatch(password)) {
      return 'Password must include at least one special character'.tr();
    }

    return null; // Password is valid
  }

  static String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Address cannot be empty'.tr();
    }

    // Check length constraints
    if (address.length < 50) {
      return 'Address must be at least 50 characters long'.tr();
    }
    if (address.length > 150) {
      return 'Address must be no more than 150 characters long'.tr();
    }

    // Check for mix of numbers and letters
    final RegExp hasLetters = RegExp(r'[a-zA-Z]');
    final RegExp hasNumbers = RegExp(r'\d');

    if (!hasLetters.hasMatch(address) || !hasNumbers.hasMatch(address)) {
      return 'Address must include both letters and numbers'.tr();
    }

    return null; // Address is valid
  }
}
