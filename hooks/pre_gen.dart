import 'package:mason/mason.dart';

void run(HookContext context) {
  final bool isGlobal = context.vars['is_global'] as bool;

  // Determine the output directory based on whether it's global
  String outputDirectory;

  if (isGlobal) {
    context.vars['is_with_page'] = false;
    context.vars['is_with_widget'] = false;
    context.logger.info('Global mode enabled: skipping page and widget generation.');
  
  }

}
