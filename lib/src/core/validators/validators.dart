class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ); // Regex for email validation
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? validateCacheTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title for the cache';
    } else if (value.length < 3) {
      return 'Title must be at least 3 characters long';
    } else if (value.length > 100) {
      return 'Title must be less than 100 characters';
    }
    return null;
  }

  static String? validateLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a link';
    }
    final linkRegExp = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    );
    if (!linkRegExp.hasMatch(value)) {
      return 'Please enter a valid link';
    }
    return null;
  }

  static bool isValidLink(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final linkRegExp = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    );
    if (!linkRegExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
