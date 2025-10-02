import 'package:firebase_auth/firebase_auth.dart';

/// Hey everyone! This is our Authentication Service Class
///
/// So basically, this class handles all our Google login stuff using Firebase.
/// The cool thing is we don't need any extra packages - Firebase does it all!
///
/// Here's what makes this secure:
/// - Firebase automatically manages our auth tokens
/// - We never store passwords - Google handles that part
/// - OAuth 2.0 is like the gold standard for secure login
/// - Firebase keeps refreshing tokens so users stay logged in safely

class AuthService {
  // Step 1.1

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Step 1.2
    } on FirebaseAuthException catch (error) {
      // Console error messages, in case you get stuck.
      // These are Firebase-specific errors (the most common ones)
      print('❌ Firebase Auth error: ${error.code} - ${error.message}');

      // Quick translation of common error codes:
      // 'popup-closed-by-user' = User closed the popup
      // 'cancelled-popup-request' = They tried to open multiple popups
      // 'popup-blocked' = Browser blocked our popup (enable popups)
      return null;
    } catch (error) {
      // Catch-all for any other errors
      print('❌ Something unexpected happened: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      // Step 1.3
    } catch (error) {
      print('❌ Logout failed: $error');
    }
  }

  Map<String, dynamic>? getUserDataAsJson() {
    // Step 1.4

    return {
      /*
      'userId': user.uid, // Firebase's unique ID for this user
      'email': user.email, // Their email from Google
      'displayName': user.displayName, // Their name
      'photoURL': user.photoURL, // Profile picture URL
      'emailVerified': user.emailVerified, // Has Google verified their email?
      'isAnonymous':
          user.isAnonymous, // Are they anonymous? (nope, they used Google)
      'phoneNumber': user.phoneNumber, // Phone if they provided it
      'creationTime': user.metadata.creationTime
          ?.toIso8601String(), // When they first signed up
      'lastSignInTime': user.metadata.lastSignInTime
          ?.toIso8601String(), // Last time they logged in
      'tenantId': user.tenantId, // For multi-tenant apps (advanced stuff)
      'refreshToken':
          'HIDDEN_FOR_SECURITY', // Hide this token for security reasons
      'providerData': user.providerData
          .map((info) => {
                'providerId':
                    info.providerId, // "google.com"  shows they used Google
                'uid': info.uid, // Google's ID for them
                'displayName': info.displayName, // Name from Google
                'email': info.email, // Email from Google
                'photoURL': info.photoURL, // Photo from Google
                'phoneNumber': info.phoneNumber, // Phone from Google (if any)
              })
          .toList(),
      'authMethod': 'Firebase Built-in Google Auth',
      'workshopNote': 'See how clean this is? Firebase handles everything - '
          'no complex setup needed!',
    */
    };
  }
}
