// Implements the all-in-all exception(s) for:
// - Wrong Password
// - User not found and etc
class InvalidCredentialAuthException implements Exception {}

class TooManyRequestsAuthException implements Exception {}

// Implements the exception for badly formatted email addresses
class InvalidEmailAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}


// ** Generic Exceptions **
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
