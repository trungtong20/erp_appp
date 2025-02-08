
part of 'user_cubit.dart';
class UserState extends Equatable {
  final List<UserModel> users;
  final bool isLoading;
  final String? errorMessage;

  const UserState({this.users = const [], this.isLoading = false, this.errorMessage});

  UserState copyWith({List<UserModel>? users, bool? isLoading, String? errorMessage}) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [users, isLoading, errorMessage];
}