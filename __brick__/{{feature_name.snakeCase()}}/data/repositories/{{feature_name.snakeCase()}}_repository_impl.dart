

import '../datasource/remote/{{feature_name.snakeCase()}}_remote_datasource.dart';
import '../datasource/local/{{feature_name.snakeCase()}}_local_datasource.dart';
import '../../domain/repositories/{{feature_name.snakeCase()}}_repository.dart';

class {{feature_name.pascalCase()}}RepositoryImpl extends {{feature_name.pascalCase()}}Repository {
  final {{feature_name.pascalCase()}}RemoteDataSource remoteDataSource;
  final {{feature_name.pascalCase()}}LocalDataSource localDataSource;

  {{feature_name.pascalCase()}}RepositoryImpl({required this.remoteDataSource, required this.localDataSource});

}
