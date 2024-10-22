import 'package:mobile_cityzen/shared/local/secure_storage/secure_storage.dart';

import '{{feature_name.snakeCase()}}_local_datasource.dart';

class {{feature_name.pascalCase()}}LocalDataSourceImpl extends {{feature_name.pascalCase()}}LocalDataSource {
  SecureStorage secureStorage;

  {{feature_name.pascalCase()}}LocalDataSourceImpl({required this.secureStorage});
}
