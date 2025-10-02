import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'firebase_options.dart';
import 'auth_service.dart';

/// Welcome to our Firebase Authentication Workshop!
///
/// Today we're building a real authentication app that shows you:
/// - How to set up Firebase in Flutter
/// - Google OAuth authentication
/// - Real-time auth state management
/// - How to display user data securely
/// - Basic security concepts

void main() async {
  // Step 2.1

  runApp(const FirebaseAuthWorkshopApp());
}

/// This is our main app widget
class FirebaseAuthWorkshopApp extends StatelessWidget {
  const FirebaseAuthWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Workshop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),
      home: const AuthenticationWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Authentication Wrapper Widget
///
/// This widget listens
/// to authentication state changes and displays
/// the appropriate screen based on whether the user is signed in or not.
///
/// StreamBuilder automatically rebuilds the UI when
/// the authentication state changes, providing real-time updates.
class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  // Step 2.2

  @override
  Widget build(BuildContext context) {
    ///
    return StreamBuilder<User?>(
      ///
      stream: Stream.value(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final User? user = snapshot.data;
        // Remove the following dummy return statement after you've implemented the UserHomeScreen and SignInScreen step.
        return const Scaffold(
          body: Center(
            child: Text('Stream is missing (not yet implemented?).'),
          ),
        );
      },
    );
  }
}

/// Sign-In Screen Widget
///
/// This screen is displayed when the user is not authenticated.
/// It provides a simple interface for Google sign-in with error handling.
class SignInScreen extends StatefulWidget {
  final AuthService authService;

  const SignInScreen({super.key, required this.authService});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSigningIn = false;
  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isSigningIn = true;
    });

    try {
      // Step 2.3

      // vvv Show the following block below if login success
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome, User!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
      // ^^^
    } catch (error) {
      // Handle sign-in errors with user-friendly messages
      print('❌ Sign-in failed: $error');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in failed. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with workshop title
      appBar: AppBar(
        title: const Text(
          'Firebase Auth Workshop',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Workshop header with icon
            Icon(
              Icons.security,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 32),

            // Welcome text
            Text(
              'Welcome to Firebase Authentication!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // What we'll learn
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What you\'ll learn:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _LearningPointItem(
                      icon: Icons.verified_user,
                      text: 'Secure Google OAuth 2.0 authentication',
                    ),
                    const _LearningPointItem(
                      icon: Icons.cloud,
                      text: 'Firebase authentication integration',
                    ),
                    const _LearningPointItem(
                      icon: Icons.data_object,
                      text: 'User authentication data handling',
                    ),
                    const _LearningPointItem(
                      icon: Icons.logout,
                      text: 'Secure sign-out procedures',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Security information
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your credentials are handled securely by Google and Firebase. No passwords are stored in this app.',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Google Sign-In Button
            ElevatedButton.icon(
              onPressed: _isSigningIn ? null : _handleGoogleSignIn,
              icon: _isSigningIn
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Image.asset(
                      'icons/google_logo.png',
                      height: 24,
                      width: 24,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.login, size: 24),
                    ),
              label: Text(
                _isSigningIn ? 'Signing in...' : 'Sign in with Google',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LearningPointItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _LearningPointItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

/// User Home Screen Widget
///
/// This screen shows all the user data we get from Firebase
/// and demonstrates how to handle user sessions properly.
class UserHomeScreen extends StatefulWidget {
  final AuthService authService;

  const UserHomeScreen({super.key, required this.authService});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool _isSigningOut = false;

  /// Handle Sign Out
  ///
  /// Always give users control over their sessions. This is both
  /// good UX and good security practice.
  Future<void> _handleSignOut() async {
    setState(() {
      _isSigningOut = true;
    });

    try {
      // Step 2.4

      // Show success message after signing out
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully signed out!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('❌ Sign-out failed: $error');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-out failed. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSigningOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current user data
    final user = null;
    final userData = null;

    return Scaffold(
      // App bar with user greeting and sign-out action
      appBar: AppBar(
        title: Text(
          'Welcome, ${user?.displayName ?? 'User'}!',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Sign-out button in app bar
          IconButton(
            onPressed: _isSigningOut ? null : _handleSignOut,
            icon: _isSigningOut
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.logout),
            tooltip: 'Sign Out',
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // User profile picture
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),

                    const SizedBox(width: 20),

                    // User basic info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DISPLAY NAME',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "EMAIL",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Authenticated',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Section header for authentication data
            Text(
              'Firebase Authentication Data',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 8),

            // Explanation text
            Text(
              'Here\'s all the authentication data Firebase provides about you. '
              'This data is securely managed by Firebase and automatically validated.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 16),

            // JSON data display
            Card(
              elevation: 4,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.data_object,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'User Authentication JSON',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Pretty-printed JSON
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: SelectableText(
                        userData != null
                            ? _formatJsonString(jsonEncode(userData))
                            : 'No user data available',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Security information section
            Card(
              color: Colors.blue.shade50,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Security Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _SecurityPointItem(
                      icon: Icons.verified,
                      text: 'Your session is secured with Firebase Auth tokens',
                    ),
                    const _SecurityPointItem(
                      icon: Icons.timer,
                      text: 'Tokens are automatically refreshed and validated',
                    ),
                    const _SecurityPointItem(
                      icon: Icons.lock,
                      text: 'No sensitive credentials are stored locally',
                    ),
                    const _SecurityPointItem(
                      icon: Icons.cloud_done,
                      text: 'Authentication state syncs across devices',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Sign-out button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isSigningOut ? null : _handleSignOut,
                icon: _isSigningOut
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout),
                label: Text(
                  _isSigningOut ? 'Signing out...' : 'Sign Out',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red.shade700,
                  side: BorderSide(color: Colors.red.shade200),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to make JSON look pretty
  ///
  /// This helper method takes a JSON string and formats it with proper
  /// indentation to make it easier to read in the UI.
  String _formatJsonString(String jsonString) {
    try {
      // Parse and re-encode with nice indentation
      final dynamic jsonObject = jsonDecode(jsonString);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      // If something goes wrong, just return the original
      return jsonString;
    }
  }
}

/// A reusable widget for security information points
class _SecurityPointItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SecurityPointItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.blue.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
