import 'package:model_generator/src/model.dart';

class ModifierTemplate {
  final Model model;

  ModifierTemplate(this.model);

  @override
  String toString() {
    return '''
${model.modifierClassName} get ${model.camelCaseName} => ${model.modifierClassName}();

set ${model.camelCaseName}(${model.className} model) => Repository().set(model);

/// @nodoc
class ${model.modifierClassName} extends ${model.mainClassName} {
   final ${model.className} Function()? _getOverride;
   final void Function(${model.className})? _setOverride;
   final void Function()? _sendOverride;

   const ${model.modifierClassName}([
     this._getOverride,
     this._setOverride,
     this._sendOverride,
   ]);

   ${model.className} get _get =>
       (_getOverride != null) ? _getOverride!.call() : Repository().get(const ${model.className}());

   void _set(${model.className} model) =>
       (_setOverride != null) ? _setOverride!.call(model) : Repository().set(model);

   @override
   void send() => (_sendOverride != null) ? _sendOverride!.call() : Repository().sendModel(_get);

  ${model.modifierParameterList()}

  ${model.hasDartCoreCollection ? processMethod : ''}
  $modifierMerge
}
    ''';
  }

  String get processMethod {
    return '''
E _process<E extends Object>(E object) {
  ${model.processParameterConversions()}
  return object;
}
    ''';
  }

  String get modifierMerge {
    String maybeLeftBrace = model.parameters.isEmpty ? '' : '{';
    String maybeRightBrace = model.parameters.isEmpty ? '' : '}';

    return '''
@override
${model.abstractClassName} merge($maybeLeftBrace
  ${model.nullableParameterList()}
$maybeRightBrace) {
  ${model.modifierMergeSetters()}
  return this;
}
    ''';
  }
}
