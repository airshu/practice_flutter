import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:xp_lints/src/rules/amend_model_suffix.dart';
import 'package:xp_lints/src/rules/dont_say_his_name.dart';
import 'package:xp_lints/src/rules/long_pubspec.dart';
import 'package:xp_lints/src/rules/use_emit_synchronously.dart';
import 'package:xp_lints/src/rules/util_methods_be_static.dart';

PluginBase createPlugin() => _XpLintsPlugin();

class _XpLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs _) => [
        // AmendModelSuffix(),
        // LongPubspec(),
        // DontSayHisName(),
        // UtilMethodsBeStatic(),
        UseEmitSynchronously(),
      ];
}
