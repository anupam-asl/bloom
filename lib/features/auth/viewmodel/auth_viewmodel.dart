import 'package:bloom_health_app/core/failure/failure.dart';
import 'package:bloom_health_app/features/auth/models/user_model.dart';
import 'package:bloom_health_app/features/auth/repositories/auth_remote_repository.dart';
import 'package:bloom_health_app/features/auth/viewmodel/current_user_notifier.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel {
  late AuthRemoteRepository _authRemoteRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null; // Initial state can be null or any other default value
  }

  Future<void> signInWithGoogle() async {
    state = AsyncValue.loading();
    final result = await _authRemoteRepository.signInWithGoogle();
    final _ = switch (result) {
      Left<AppFailure, UserModel>(value: final left) =>
        state = AsyncValue.error(left.message, StackTrace.current),
      Right<AppFailure, UserModel>(value: final right) => state = _loginSuccess(
        right,
      ),
    };
  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user) {
    _currentUserNotifier.setCurrentUser(user);
    return state = AsyncValue.data(user);
  }

  Future<void> signOut() async {
    state = AsyncValue.loading();
    final result = await _authRemoteRepository.signOut();
    final _ = switch (result) {
      Left<AppFailure, void>(value: final left) => state = AsyncValue.error(
        left.message,
        StackTrace.current,
      ),
      Right<AppFailure, void>(value: final _) => _clearCurrentUser(),
    };
  }

  void _clearCurrentUser() {
    _currentUserNotifier.clearValue();
  }
}
