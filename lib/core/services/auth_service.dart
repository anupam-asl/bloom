import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:bloom_health_app/features/auth/entities/session.dart';
import 'storage_service.dart';

class AuthService {
  // static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  // Use clientId only for Web and iOS explicitly.
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: "938134073437-ftah4b79ma4skd43qknkj6ledf7cj6bm.apps.googleusercontent.com",
  );
  // static Future<Session?> signInWithGoogle() async {
  //   final user = await _googleSignIn.signIn();
  //   if (user == null) return null;

  //   final auth = await user.authentication;

  //   final session = Session(
  //     provider: 'google',
  //     name: user.displayName,
  //     email: user.email,
  //     photoUrl: user.photoUrl,
  //     idToken: auth.idToken,
  //   );

  //   await StorageService.saveSession(session);
  //   return session;
  // }

  static Future<Session?> signInWithGoogle() async {
  try {
    final user = await _googleSignIn.signIn();
    if (user == null) {
      throw Exception("Google sign-in cancelled by user.");
    }

    final auth = await user.authentication;

    final session = Session(
      provider: 'google',
      name: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl,
      idToken: auth.idToken,
    );

    await StorageService.saveSession(session);
    return session;
  } catch (e) {
    rethrow; // Pass the error up so UI can show it
  }
}

  static Future<Session?> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );

    final fullName = [
      credential.givenName ?? '',
      credential.familyName ?? ''
    ].where((e) => e.isNotEmpty).join(' ');

    final session = Session(
      provider: 'apple',
      name: fullName.isEmpty ? null : fullName,
      email: credential.email,
      idToken: credential.identityToken,
    );

    await StorageService.saveSession(session);
    return session;
  }

  static Future<void> signOut() async {
    await StorageService.clearSession();
    try {
      await _googleSignIn.disconnect();
    } catch (_) {}
  }
}
