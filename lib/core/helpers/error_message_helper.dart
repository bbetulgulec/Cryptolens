class ErrorMessageHelper {
  static String parse(String error) {
    if (error.contains('invalid format')) {
      return 'Invalid email address format.';
    } else if (error.contains('already registered')) {
      return 'This email address is already registered.';
    } else if (error.contains('Password should be')) {
      return 'The password must be at least 6 characters long.';
    } else if (error.contains('network')) {
      return 'Check your internet connection.';
    }
    return 'An error occurred. Please try again.';
  }
}
