import 'package:braze_plugin_web/src/braze_plugin_js.dart';
import 'package:braze_plugin_web/src/helper/js_object_wrapper.dart';

class BrazeCards extends JsObjectWrapper<ListBrazeCardsJsImpl> {
  BrazeCards._fromJsObject(ListBrazeCardsJsImpl jsObject) : super.fromJsObject(jsObject);
  static final _expando = Expando<BrazeCards>();

  /// Creates a new App from a [jsObject].
  static BrazeCards getInstance(ListBrazeCardsJsImpl jsObject) {
    return _expando[jsObject] ??= BrazeCards._fromJsObject(jsObject);
  }

  /// Also can be
  /// HttpsCallableResult._fromJsObject(
//       functions_interop.HttpsCallableResultJsImpl jsObject)
//       : _data = dartify(jsObject.data),
//         super.fromJsObject(jsObject);
}
