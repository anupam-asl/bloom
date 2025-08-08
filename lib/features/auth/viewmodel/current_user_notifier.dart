import 'package:bloom_health_app/features/auth/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  UserModel? build() {
    return null;
  }

  void setCurrentUser(UserModel user) {
    state = user;
  }

  void clearValue() {
    state = null;
  }
}
