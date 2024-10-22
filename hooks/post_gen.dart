import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final featureName = context.vars['feature_name'];
  final isWithDI = (context.vars['is_with_di'] == true);
  final bool isGlobal = context.vars['is_global'] as bool;
  final String outputDirectory = isGlobal ? 'shared/global_features' : 'features';


  if (isWithDI) {

    final pascalCaseFeature = toPascalCase(featureName);
    final snakeCaseFeature = toSnakeCase(featureName);

    print('Current Directory: ${Directory.current}');
    final diFile = File(isGlobal ? '../../di/Injector.dart' : '../di/Injector.dart');

    print(diFile.existsSync());
    
    if (diFile.existsSync()) {
      String fileContent = diFile.readAsStringSync();

      // Create import statements
      final importStatements = '''
    import '../${outputDirectory}/$snakeCaseFeature/data/datasource/local/${snakeCaseFeature}_local_datasource.dart';
    import '../${outputDirectory}/$snakeCaseFeature/data/datasource/local/${snakeCaseFeature}_local_datasource_impl.dart';
    import '../${outputDirectory}/$snakeCaseFeature/data/datasource/remote/${snakeCaseFeature}_remote_datasource.dart';
    import '../${outputDirectory}/$snakeCaseFeature/data/datasource/remote/${snakeCaseFeature}_remote_datasource_impl.dart';
    import '../${outputDirectory}/$snakeCaseFeature/data/repositories/${snakeCaseFeature}_repository_impl.dart';
    import '../${outputDirectory}/$snakeCaseFeature/domain/repositories/${snakeCaseFeature}_repository.dart';
    import '../${outputDirectory}/$snakeCaseFeature/domain/use_cases/fetch_${snakeCaseFeature}_use_case.dart';

  ''';

      // Check if the imports already exist and add if not
      if (!fileContent.contains(importStatements.trim())) {
        fileContent = addImports(fileContent, importStatements);
      }

      // Inject to provideDataSources
      if (fileContent.contains('void provideDataSources() {')) {
        final dataSourceInjection = '''
      // $pascalCaseFeature
      injector.registerFactory<${pascalCaseFeature}LocalDataSource>(
          () => ${pascalCaseFeature}LocalDataSourceImpl(secureStorage: injector.get<SecureStorage>()));
      injector.registerFactory<${pascalCaseFeature}RemoteDataSource>(
          () => ${pascalCaseFeature}RemoteDataSourceImpl(networkService: injector.get<NetworkService>()));
        ''';

        fileContent = injectIntoFunction(
          fileContent, 
          'provideDataSources', 
          dataSourceInjection
        );
      }

      // Inject to provideRepositories
      if (fileContent.contains('void provideRepositories() {')) {
        final repositoryInjection = '''
      // $pascalCaseFeature
      injector.registerFactory<${pascalCaseFeature}Repository>(
          () => ${pascalCaseFeature}RepositoryImpl(
            localDataSource: injector.get<${pascalCaseFeature}LocalDataSource>(),
            remoteDataSource: injector.get<${pascalCaseFeature}RemoteDataSource>(),
          ));
        ''';

        fileContent = injectIntoFunction(
          fileContent, 
          'provideRepositories', 
          repositoryInjection
        );
      }

      // Inject to provideUseCases
      if (fileContent.contains('void provideUseCases() {')) {
        final useCaseInjection = '''
      // $pascalCaseFeature
      injector.registerFactory<Fetch${pascalCaseFeature}UseCase>(
        () => Fetch${pascalCaseFeature}UseCase(
          repository: injector.get<${pascalCaseFeature}Repository>(),
        ),
      );
        ''';

        fileContent = injectIntoFunction(
          fileContent, 
          'provideUseCases', 
          useCaseInjection
        );
      }

      // Write the modified content back to di.dart
      diFile.writeAsStringSync(fileContent);
    }
  }

}

String injectIntoFunction(String fileContent, String functionName, String injection) {
  final startIndex = fileContent.indexOf('void $functionName() {') + 'void $functionName() {'.length;
  final endIndex = fileContent.indexOf('}', startIndex);
  
  final before = fileContent.substring(0, startIndex);
  final functionBody = fileContent.substring(startIndex, endIndex).trim();
  final after = fileContent.substring(endIndex);
  
  // Insert the new content inside the function body
  final newFunctionBody = '\n$functionBody\n$injection\n';

  return before + newFunctionBody + after;
}

String addImports(String fileContent, String imports) {
  // Find the place to insert imports (usually at the top)
  final importSectionEnd = fileContent.indexOf('import') != -1 
      ? fileContent.indexOf('import', fileContent.indexOf('import') + 1)
      : 0;

  return fileContent.substring(0, importSectionEnd) + imports + fileContent.substring(importSectionEnd);
}

String toPascalCase(String text) {
  return text.split('_').map((str) => str[0].toUpperCase() + str.substring(1)).join();
}

String toSnakeCase(String text) {
  // Convert the text to lowercase and replace spaces with underscores
  return text.toLowerCase().replaceAll(' ', '_');
}
