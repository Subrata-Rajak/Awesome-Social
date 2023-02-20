class AuthFailure {
  final String message;

  const AuthFailure([
    this.message = "An unknown error occurred",
  ]);

  factory AuthFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const AuthFailure(
            'Please enter a Strong password like: Wc{xA+ps(W8o?h%');
      case 'invalid-email':
        return const AuthFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const AuthFailure(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return const AuthFailure(
            'Operation is not allowed. Please Contact Support');
      case 'user-disabled':
        return const AuthFailure(
            'This user has been disabled. Please contact support for help');
      default:
        return const AuthFailure();
    }
  }
}
