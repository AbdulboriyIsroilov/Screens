import 'package:equatable/equatable.dart';
import 'package:screens/data/models/user_models/my_model.dart';

class MyState extends Equatable {
  final String? errorMessage;
  final bool loading;
  final MyModel meDetail;

  const MyState({
    required this.errorMessage,
    required this.loading,
    required this.meDetail,
  });

  factory MyState.initial() {
    return MyState(
      errorMessage: null,
      loading: true,
      meDetail: MyModel(
        id: 0,
        fullName: "",
        email: "",
        phoneNumber: "",
        gender: "",
        birthDate: "",
      ),
    );
  }

  MyState copyWith({
    String? errorMessage,
    bool? loading,
    MyModel? meDetail,
  }) => MyState(
    errorMessage: errorMessage ?? this.errorMessage,
    loading: loading ?? this.loading,
    meDetail: meDetail ?? this.meDetail,
  );

  @override
  List<Object?> get props => [errorMessage, loading, meDetail];
}
