import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'braze_plugin_js.dart';


/// Simplified proxy version of the Braze SDK.
/// If more control over the Braze Web SDK is needed, use `BrazePluginJS`
/// directly or create a new proxy like this one.
class BrazeClient {
  BrazeClient._();

  static void initializeWithOptions({
    required String apiKey,
    required InitializationOptions options,
    bool automaticallyShowInAppMessages = false,
  }) {
    BrazePluginJS.initialize(apiKey, options);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  static void initialize({
    required String apiKey,
    required String baseUrl,
    bool automaticallyShowInAppMessages = false,
    bool enableLogging = false,
  }) {
    var options = InitializationOptions(
        baseUrl: baseUrl,
        enableLogging: enableLogging);

    BrazePluginJS.initialize(apiKey, options);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  static void identify(String userId) {
    BrazePluginJS.changeUser(userId, null);
    BrazePluginJS.openSession();
  }

  static void setCustomAttribute(
      String key,
      dynamic value,
      {bool flush = false}
    ) {
    var user = BrazePluginJS.getUser();
    user.setCustomUserAttribute(key, value, false);

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  static void setCustomAttributes(
      Map<String, dynamic> attributes,
      {bool flush = false}) {
    var user = BrazePluginJS.getUser();
    attributes.forEach((key, value) {
      user.setCustomUserAttribute(key, value, false);
    });

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  static void logCustomEvent(
      String key,
      Map<String, dynamic>? properties,
      {bool flush = false}
    ) {
    BrazePluginJS.logCustomEvent(key, properties);

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

}


/// Implementation of the Braze Plugin for Web.
class BrazePluginWeb {
  // Consider using PlatformInterface
  static late BrazePluginWeb instance;

  static void registerWith(Registrar registrar) {
    /// Don't intend to use method channel for web, as this adds an overhead
    instance = BrazePluginWeb();

    // TODO: Add callback to subscribe to content cards
    // Sets the call from JavaScript handler
    // _jsOnEvent = allowInterop((dynamic event) {
    //   //Process JavaScript call here
    // });
  }

}
