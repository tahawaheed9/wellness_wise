import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../components/dialogs/error_dialog.dart';

// Getting the instance of the current user...
User? get currentUser => FirebaseAuth.instance.currentUser;

// Registering a user...
createUser({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = currentUser;
    if (user != null) {
      return user;
    } else {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'User not logged in.',
        );
      }
    }
  } on FirebaseAuthException catch (error) {
    if (error.code == 'invalid-credential') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Credentials.',
        );
      }
    } else if (error.code == 'invalid-email') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Email.',
        );
      }
    } else if (error.code == 'email-already-in-use') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Email address is already in use.',
        );
      }
    } else {
      if (context.mounted) {
        await showErrorDialog(context, error.code);
      }
    }
  } catch (error) {
    if (context.mounted) {
      await showErrorDialog(
        context,
        'An Authentication Error Occurred.',
      );
    }
  }
}

// Logging in the user...
loginUser({
  required BuildContext context,
  required String email,
  required String password,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = currentUser;
    if (user != null) {
      return user;
    } else {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'User not logged in.',
        );
      }
    }
  } on FirebaseAuthException catch (error) {
    if (error.code == 'invalid-credential') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Credential.',
        );
      }
    } else if (error.code == 'invalid-email') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Email.',
        );
      }
    } else if (error.code == 'too-many-requests') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Too many requests. Please try again later.',
        );
      }
    } else {
      if (context.mounted) {
        await showErrorDialog(context, error.code);
      }
    }
  } catch (error) {
    if (context.mounted) {
      await showErrorDialog(
        context,
        'An Authentication Error Occurred.',
      );
    }
  }
}

// Reset Password...
sendResetPassword({
  required BuildContext context,
  required String toEmail,
}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
  } on FirebaseAuthException catch (error) {
    if (error.code == 'invalid-credential') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Credentials.',
        );
      }
    } else if (error.code == 'invalid-email') {
      if (context.mounted) {
        await showErrorDialog(
          context,
          'Invalid Email.',
        );
      }
    } else {
      if (context.mounted) {
        await showErrorDialog(context, error.code);
      }
    }
  } catch (error) {
    if (context.mounted) {
      await showErrorDialog(
        context,
        'An Authentication Error Occurred.',
      );
    }
  }
}
