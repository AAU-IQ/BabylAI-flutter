// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HelpScreenStore on _HelpScreenStore, Store {
  late final _$helpScreenAtom =
      Atom(name: '_HelpScreenStore.helpScreen', context: context);

  @override
  HelpScreenEntity? get helpScreen {
    _$helpScreenAtom.reportRead();
    return super.helpScreen;
  }

  @override
  set helpScreen(HelpScreenEntity? value) {
    _$helpScreenAtom.reportWrite(value, super.helpScreen, () {
      super.helpScreen = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HelpScreenStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_HelpScreenStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getHelpScreenAsyncAction =
      AsyncAction('_HelpScreenStore.getHelpScreen', context: context);

  @override
  Future<void> getHelpScreen(String id) {
    return _$getHelpScreenAsyncAction.run(() => super.getHelpScreen(id));
  }

  @override
  String toString() {
    return '''
helpScreen: ${helpScreen},
isLoading: ${isLoading},
success: ${success}
    ''';
  }
}
