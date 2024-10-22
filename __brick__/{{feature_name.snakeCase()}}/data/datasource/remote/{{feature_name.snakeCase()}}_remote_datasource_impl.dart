
import 'package:mobile_cityzen/shared/network/network_service.dart';
import '{{feature_name.snakeCase()}}_remote_datasource.dart';


class {{feature_name.pascalCase()}}RemoteDataSourceImpl extends {{feature_name.pascalCase()}}RemoteDataSource {
  final NetworkService networkService;

  {{feature_name.pascalCase()}}RemoteDataSourceImpl({required this.networkService});

}
