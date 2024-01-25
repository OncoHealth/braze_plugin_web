import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'braze_plugin_js.dart';

/// Simplified proxy version of the Braze SDK.
/// If more control over the Braze Web SDK is needed, use `BrazePluginJS`
/// directly or create a new proxy like this one.
class BrazeClient {
  BrazeClient._();

  /// A more robust initializeR to replace [initialize], allowing the
  /// provision of [InitializationOptions]
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

  /// An initializer for the [BrazeClient]. This or [initializeWithOptions]
  /// ***must*** be called for further operation with the [BrazeClient]
  static void initialize({
    required String apiKey,
    required String baseUrl,
    bool automaticallyShowInAppMessages = false,
    bool enableLogging = false,
  }) {
    final options =
        InitializationOptions(baseUrl: baseUrl, enableLogging: enableLogging);

    BrazePluginJS.initialize(apiKey, options);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  /// Performs [BrazePluginJS.changeUser] and [BrazePluginJS.openSession] for
  /// the provided [userId], starting a new session for the provided credential.
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  static void identify(String userId, String? signature) {
    BrazePluginJS.changeUser(userId, signature);
    BrazePluginJS.openSession();
  }

  /// Sets [value] as a custom attribute for the given [ BrazePluginJS.getUser]
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  static void setCustomAttribute(
    String key,
    dynamic value, {
    bool flush = false,
  }) {
    final user = BrazePluginJS.getUser();
    user.setCustomUserAttribute(key, value, false);

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// Sets [attributes] for the given [BrazePluginJS.getUser]
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  static void setCustomAttributes(
    Map<String, dynamic> attributes, {
    bool flush = false,
  }) {
    var user = BrazePluginJS.getUser();
    attributes.forEach((key, value) {
      user.setCustomUserAttribute(key, value, false);
    });

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// Logs a custom event [key] to braze with [properties]
  /// that are [jsonEncode]'d.
  ///
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  static void logCustomEvent(
    String key,
    String? properties, {
    bool flush = false,
  }) {
    final brazeProperties = properties == null || properties.isEmpty
        ? properties
        : jsonParse(properties);

    BrazePluginJS.logCustomEvent(key, brazeProperties);

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

    // Sets the call from JavaScript handler
    // _jsOnEvent = allowInterop((dynamic event) {
    //   //Process JavaScript call here
    // });
  }
}
