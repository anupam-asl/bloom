import 'package:bloom_health_app/core/failure/failure.dart';
import 'package:bloom_health_app/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteRepository({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Current user
  User? get currentUser => _firebaseAuth.currentUser;

  Future<Either<AppFailure, UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(AppFailure('User cancelled sign-in'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      if (userCredential.credential != null) {
        return Right(
          UserModel(
            uid: userCredential.user!.uid,
            email: userCredential.user?.email,
            name: userCredential.user?.displayName,
            photoUrl: userCredential.user?.photoURL,
          ),
        );
      }
      return Left(AppFailure('User cancelled sign-in'));
    } catch (e) {
      return Left(AppFailure('Failed to sign in with Google: $e'));
    }
  }

  Future<Either<AppFailure, void>> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      return Right(null);
    } catch (e) {
      return Left(AppFailure('Failed to sign out: $e'));
    }
  }
}
