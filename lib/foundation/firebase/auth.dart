import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

@Riverpod(keepAlive: true, dependencies: [])
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true, dependencies: [firebaseAuth])
AuthFoundation authFoundation(AuthFoundationRef ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthFoundation(firebaseAuth);
}

enum AuthStatus {
  /// 未認証
  unauthenticated,

  /// 取得・認証中
  loading,

  /// 認証済み
  authenticated,
}

class AuthFoundation {
  const AuthFoundation(this._auth);

  final FirebaseAuth _auth;

  User? get currentUser => _auth.currentUser;

  Future<String?> getIdToken() async {
    return _auth.currentUser!.getIdToken();
  }

  AuthStatus onAuthStatusChanged(WidgetRef ref) {
    final auth = ref.read(authFoundationProvider);
    final user = auth.currentUser;

    if (user == null) {
      return AuthStatus.unauthenticated;
    }
    return AuthStatus.authenticated;
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
