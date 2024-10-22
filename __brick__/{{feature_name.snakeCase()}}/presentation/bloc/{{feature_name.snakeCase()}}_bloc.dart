
import 'package:mobile_cityzen/di/injector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '{{feature_name.snakeCase()}}_event.dart';

part '{{feature_name.snakeCase()}}_state.dart';

class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, {{feature_name.pascalCase()}}State> {
  
  {{feature_name.pascalCase()}}Bloc() : super(const {{feature_name.pascalCase()}}State.initial()) {}
  
  // Example howt to use bloc
  // final Fetch{{feature_name.pascalCase()}}UseCase _fetch{{feature_name.pascalCase()}}UseCase = injector.get<Fetch{{feature_name.pascalCase()}}UseCase>();
  
  // {{feature_name.pascalCase()}}Bloc() : super(const {{feature_name.pascalCase()}}State.initial()) {
  //   on<Call{{feature_name.pascalCase()}}>(call{{feature_name.pascalCase()}});
  // }

  // bool get isFetching => state.state != {{feature_name.pascalCase()}}ConcreteState.loading;


  // Future<void> call{{feature_name.pascalCase()}}(Call{{feature_name.pascalCase()}} event, Emitter<{{feature_name.pascalCase()}}State> emit) async {
  //   emit(
  //     state.copyWith(
  //       state: {{feature_name.pascalCase()}}ConcreteState.loading,
  //       isLoading: true
  //     )
  //   );
  //   final response = await _fetch{{feature_name.pascalCase()}}UseCase.execute();
  //   response.fold((failure) {
  //     emit(
  //       state.copyWith(
  //         state: {{feature_name.pascalCase()}}ConcreteState.failure,
  //         message: failure.message,
  //         isLoading: false
  //       )
  //     );
  //   }, (resp) {
  //     final User user = User.fromJson(resp.data);
  //     emit(
  //       state.copyWith(
  //         state: {{feature_name.pascalCase()}}ConcreteState.success,
  //         message: resp.message,
  //         isLoading: false
  //       )
  //     );
  //   });
  // }

}