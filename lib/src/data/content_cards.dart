import 'package:braze_plugin_web/src/braze_plugin_js.dart';
import 'package:braze_plugin_web/src/helper/js_object_wrapper.dart';

class ContentCards extends JsObjectWrapper<ListBrazeCardsJsImpl> {
  /// Also can be something like
  ///ContentCards._fromJsObject(
  ///ListBrazeCardsJsImpl jsObject)
  ///: _data = dartify(jsObject.data),
  ///super.fromJsObject(jsObject);
  ContentCards._fromJsObject(ListBrazeCardsJsImpl jsObject) : super.fromJsObject(jsObject);
  static final _expando = Expando<ContentCards>();

  /// Creates a new BrazeCards from a [jsObject].
  static ContentCards getInstance(ListBrazeCardsJsImpl jsObject) {
    return _expando[jsObject] ??= ContentCards._fromJsObject(jsObject);
  }
}
