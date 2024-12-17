extension StringValidation on String {
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    return length > 6;
  }
}
