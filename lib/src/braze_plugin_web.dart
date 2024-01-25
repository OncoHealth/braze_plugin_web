import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:js';

import 'package:braze_plugin_web/src/data/content_cards.dart';
import 'package:braze_plugin_web/src/helper/parse_helper.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'braze_plugin_js.dart';
import 'helper/utils.dart';

/// Simplified proxy version of the Braze SDK.
/// If more control over the Braze Web SDK is needed, use `BrazePluginJS`
/// directly or create a new proxy like this one.
class BrazeClient {
  BrazeClient._internal();
  static final BrazeClient _instance = BrazeClient._internal();

  static BrazeClient get instance => _instance;

  /// Only for internal usage to not parse content cards to Map in subscriber function and make a parsing back
  /// For this purposes we are using a one time saving cuz every requestRefreshContent cards or cachedContentCards
  /// should return a list of all content cards
  /// TODO: find a way to parse ContentCard back to js and call [.dismissContentCard()]
  Map<String, dynamic> _savedContentCards = {};

  /// A more robust initializeR to replace [initialize], allowing the
  /// provision of [InitializationOptions]
  void initializeWithOptions({
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
  void initialize({
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
  void setCustomAttribute(
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
  void setCustomAttributes(
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
  void logCustomEvent(
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

  /// braze add to subscription group
  ///
  bool addToSubscriptionGroup(String groupId) {
    return BrazePluginJS.getUser().addToSubscriptionGroup(groupId);
  }

  /// braze remove to subscription group
  ///
  bool removeToSubscriptionGroup(String groupId) {
    return BrazePluginJS.getUser().removeFromSubscriptionGroup(groupId);
  }

  /// subscribe to braze content cards
  Stream<List<Map<String, dynamic>>> subscribeToContentCardsUpdates() {
    late StreamController<List<Map<String, dynamic>>> controller;

    BrazePluginJS.subscribeToContentCardsUpdates(allowInterop((res) {
      final ContentCards response = ContentCards.getInstance(res);
      final cardsJs = response.jsObject.cards;

      if (cardsJs.isNotEmpty) {
        try {
          final List<Map<String, dynamic>> parsedCards = cardsJs.map((e) {
            final map = Map<String, dynamic>.from(dartify(e));

            ///saving this to remove if need for later
            _savedContentCards.addAll({map["id"]: e});

            //TODO: found another way how to parse, parsing extras to normal dart types
            //we doing this to parse custom braze card type such as bool which is comming to us in string type
            if (map['extras'] is Map<String, dynamic>) {
              final Map<String, dynamic> parsedMap =
                  (map['extras'] as Map<String, dynamic>)
                      .map((key, value) => MapEntry(key, parseDynamic(value)));
              map['extras'] = parsedMap;
            }
            return map;
          }).toList();

          controller.add(parsedCards);
        } catch (e) {
          //TODO: log implementation, this means we cannot parse data in correct way or response structure changed
          log(e.toString());
        }
      }
    }));

    controller = StreamController<List<Map<String, dynamic>>>.broadcast(
      onCancel: () {
        controller.close();
      },
    );

    return controller.stream;
  }

  /// request content cards updates
  void requestContentCardsRefresh({Function? onSuccess, Function? onError}) {
    BrazePluginJS.requestContentCardsRefresh(
      allowInterop(() {
        onSuccess?.call();
      }),
      allowInterop(() {
        onError?.call();
      }),
    );
  }

  /// Converting dart to js object not working for braze, take a looks on documnetation
  /// also this is used like this to much exising React and Mobile implementation
  ///
  /// unfortunatly next implementation to converting object from dart to js is not working
  /// thats why we need to store cards locally and then parse them back
  ///
  /// bool logContentCardDismissed(Map<String, dynamic> card) {
  ///   BrazePluginJS.logCardDismissal(jsify(card) as BrazeCardImpl)
  ///   return BrazePluginJS.logCardDismissal(cardsJs.jsObject);
  /// }
  bool logContentCardDismissed(String cardId) {
    final card = _savedContentCards[cardId];
    final deleted = BrazePluginJS.logCardDismissal(card);
    if (deleted) {
      _savedContentCards.removeWhere((key, value) => key == cardId);
    }
    return deleted;
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
