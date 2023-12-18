bool isStrongPassword(String password) {
  // Define your password strength criteria
  const minLength = 8;
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialCharacters =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  // Check if the password meets all criteria
  return password.length >= minLength &&
      hasUppercase &&
      hasDigits &&
      hasSpecialCharacters;
}
