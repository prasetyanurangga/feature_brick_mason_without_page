part of '{{feature_name.snakeCase()}}_bloc.dart';
sealed class {{feature_name.pascalCase()}}Event extends Equatable {
  const {{feature_name.pascalCase()}}Event();

  @override
  List<Object?> get props => [];
}

// Exmaple of Event Bloc
// class GetData{{feature_name.pascalCase()}} extends {{feature_name.pascalCase()}}Event {
//   const GetData{{feature_name.pascalCase()}}();
// }