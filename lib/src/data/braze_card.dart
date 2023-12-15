import 'dart:js_util';

import 'package:braze_plugin_web/src/braze_plugin_js.dart';
import 'package:braze_plugin_web/src/helper/js_object_wrapper.dart';

class BrazeCard extends JsObjectWrapper<BrazeCardImpl> with _Dissmissable {
  BrazeCard._fromJsObject(BrazeCardImpl jsObject) : super.fromJsObject(jsObject);
  static final _expando = Expando<BrazeCard>();

  /// Creates a new BrazeCards from a [jsObject].
  static BrazeCard getInstance(BrazeCardImpl jsObject) {
    return _expando[jsObject] ??= BrazeCard._fromJsObject(jsObject);
  }

  BrazeCard dismissCard() => BrazeCard.getInstance(_wrapUpdateFunctionCall(
        jsObject,
      ));
}

/// this is not implemented yet, so this is just a ruffly usage which you can use in future to
/// implement [braze.Cards.dismissCard] function
mixin _Dissmissable {
  /// Calls js [:dismissCard():] method on [jsObject] with [data]
  ///
  T? _wrapUpdateFunctionCall<T>(
    jsObject,
  ) {
    return callMethod(jsObject, 'dismissCard', []);
  }
}
