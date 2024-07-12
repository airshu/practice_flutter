import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class LongPubspec extends DartLintRule {
  LongPubspec() : super(code: _code);

  static const _code = LintCode(
    name: 'long_pubspec',
    problemMessage: 'This pubspec is too long, consider splitting it',
    errorSeverity: ErrorSeverity.WARNING,
  );

  @override
  List<String> get filesToAnalyze => const ['pubspec.yaml'];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (resolver.lineInfo.lineCount > 100) {
      reporter.reportErrorForOffset(_code, 0, 0);
    }
  }
}
