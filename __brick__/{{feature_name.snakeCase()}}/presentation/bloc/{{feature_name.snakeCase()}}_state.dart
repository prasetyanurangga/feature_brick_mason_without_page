
part of '{{feature_name.snakeCase()}}_bloc.dart';

enum {{feature_name.pascalCase()}}ConcreteState {
  initial,
  loading,

  {{feature_name.camelCase()}}Success,
  {{feature_name.camelCase()}}Failure,
}

class {{feature_name.pascalCase()}}State extends Equatable {
  final {{feature_name.pascalCase()}}ConcreteState state;
  final String message;
  final bool isLoading;

  const {{feature_name.pascalCase()}}State({
    this.state = {{feature_name.pascalCase()}}ConcreteState.initial,
    this.message = '',
    this.isLoading = true,
  });

  const {{feature_name.pascalCase()}}State.initial({
    this.state = {{feature_name.pascalCase()}}ConcreteState.initial,
    this.message = '',
    this.isLoading = false,
  });

  {{feature_name.pascalCase()}}State copyWith({
    {{feature_name.pascalCase()}}ConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return {{feature_name.pascalCase()}}State(
      state: state ?? this.state,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }


  @override
  List<Object> get props => [
    state,
    message,
    isLoading,
  ];

  @override
  bool get stringify => true;
  

}
