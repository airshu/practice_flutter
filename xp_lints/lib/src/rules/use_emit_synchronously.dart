import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

const _code = LintCode(
  name: 'use_emit_synchronously',
  problemMessage: "Please use isClosed to check if the bloc is closed.",
);

/// 异步使用bloc的emit前，需要判断isClosed，否则会报错
class UseEmitSynchronously extends DartLintRule {
  UseEmitSynchronously() : super(code: _code);

  @override
  Future<void> run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) async {
    final result = await resolver.getResolvedUnitResult();
    final visitor = _Visitor(reporter);
    result.unit.accept(visitor);
  }

  @override
  List<Fix> getFixes() {
    return [_AddIsClosedCheck()];
  }
}

class _Visitor extends RecursiveAstVisitor<void> {
  _Visitor(this.reporter);

  final ErrorReporter reporter;

  /// 方法调用
  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
    if (node.methodName.name == 'emit') {
      AstNode? functionNode = node.thisOrAncestorMatching((ancestor) =>
          ancestor is FunctionDeclaration || ancestor is MethodDeclaration);

      if (functionNode != null) {
        BlockFunctionBody? body;
        if (functionNode is FunctionDeclaration) {
          body = functionNode.functionExpression.body as BlockFunctionBody?;
        } else if (functionNode is MethodDeclaration) {
          body = functionNode.body as BlockFunctionBody?;
        }

        if (body != null) {
          var hasAwait = _hasAwaitBeforeAndNoCheckEmit(body, node);
          if (hasAwait) {
            reporter.reportErrorForNode(_code, node, []);
          }
        }
      }
    }
  }

  bool _hasAwaitBeforeAndNoCheckEmit(
      BlockFunctionBody body, MethodInvocation emitNode) {
    var awaitVisitor = _AwaitVisitor(emitNode);
    body.accept(awaitVisitor);
    return awaitVisitor.foundAwait &&
        !awaitVisitor.foundIsClosedCheckBeforeEmit;
  }
}

class _AwaitVisitor extends RecursiveAstVisitor<void> {
  _AwaitVisitor(this.emitNode);

  final MethodInvocation emitNode;
  bool foundAwait = false;
  bool emitEncountered = false;
  bool foundIsClosedCheckBeforeEmit = false;

  @override
  void visitAwaitExpression(AwaitExpression node) {
    if (!emitEncountered) {
      foundAwait = true;
    }
    super.visitAwaitExpression(node);
  }

  @override
  void visitIfElement(IfElement node) {
    super.visitIfElement(node);
  }

  @override
  void visitIfStatement(IfStatement node) {
    if (node.expression.toSource().contains('isClosed')) {
      foundIsClosedCheckBeforeEmit = true;
    }
    super.visitIfStatement(node);
  }

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    super.visitExpressionStatement(node);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    super.visitConditionalExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node == emitNode) {
      emitEncountered = true;
    }
    super.visitMethodInvocation(node);
  }
}

/// 用于修复的操作
class _AddIsClosedCheck extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addClassDeclaration(
      (node) {
        final changeBuilder = reporter.createChangeBuilder(
            message: 'Add isClosed check', priority: 1);
      },
    );
  }
}
