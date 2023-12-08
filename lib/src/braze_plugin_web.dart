import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:js';

import 'package:braze_plugin_web/src/data/braze_content_cards_web.dart';
import 'package:braze_plugin_web/src/helper/js_interop.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'braze_plugin_js.dart';
import 'data/braze_card.dart';
import 'helper/utils.dart';

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
    final options = InitializationOptions(baseUrl: baseUrl, enableLogging: enableLogging);

    BrazePluginJS.initialize(apiKey, options);

    if (automaticallyShowInAppMessages) {
      BrazePluginJS.automaticallyShowInAppMessages();
    }
  }

  /// Performs [BrazePluginJS.changeUser] and [BrazePluginJS.openSession] for
  /// the provided [userId], starting a new session for the provided credential.
  /// [BrazeClient.initialize] or [BrazeClient.initializeWithOptions]
  /// must be called before calling this
  static void identify(String userId) {
    BrazePluginJS.changeUser(userId, null);
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
    final brazeProperties = properties == null || properties.isEmpty ? properties : jsonParse(properties);

    BrazePluginJS.logCustomEvent(key, brazeProperties);

    if (flush) BrazePluginJS.requestImmediateDataFlush();
  }

  /// braze add to subscription group
  ///
  static bool addToSubscriptionGroup(String groupId) {
    return BrazePluginJS.getUser().addToSubscriptionGroup(groupId);
  }

  /// braze remove to subscription group
  ///
  static bool removeToSubscriptionGroup(String groupId) {
    return BrazePluginJS.getUser().removeFromSubscriptionGroup(groupId);
  }

  /// subscribe to braze content cards
  static Stream<List<BrazeContentCardWeb>> subscribeToContentCardsUpdates() {
    late StreamController<List<BrazeContentCardWeb>> controller;

    BrazePluginJS.subscribeToContentCardsUpdates(allowInterop((res) {
      final BrazeCards response = BrazeCards.getInstance(res);
      final cards = response.jsObject.cards;
      log('response: ${cards}');
      log("fd: ${cards.first.dismissCard()}");
      BrazePluginJS.logCardDismissal(cards.first);
      // final List<dynamic>? cards = response.containsKey('cards') ? response['cards'] : null;
      //
      // /// TODO: to parse content cards we need to match original braze plugin after all
      // ///check: https://github.com/braze-inc/braze-flutter-sdk/blob/7ff4c8a810b19adf71f5ca40343a352ec9105f9a/lib/braze_plugin.dart#L698
      // if (cards != null) {
      //   try {
      //     final List<BrazeContentCardWeb> parsedCards = cards.map((e) {
      //       final map = Map<String, dynamic>.from(e);
      //       final BrazeContentCardWeb parsedResult = BrazeContentCardWeb.fromJson(map);
      //       return parsedResult;
      //     }).toList();
      //     controller.add(parsedCards);
      //   } catch (e) {
      //     //TODO: log implementation, this means we cannot parse data in corrent way or response structure changed
      //     log(e.toString());
      //   }
      // }
    }));
    // BrazePluginJS.subscribeToContentCardsUpdates(allowInterop((res) {
    //   final Map response = dartify(res);
    //   log('response: $response');
    //   final List<dynamic>? cards = response.containsKey('cards') ? response['cards'] : null;
    //
    //   /// TODO: to parse content cards we need to match original braze plugin after all
    //   ///check: https://github.com/braze-inc/braze-flutter-sdk/blob/7ff4c8a810b19adf71f5ca40343a352ec9105f9a/lib/braze_plugin.dart#L698
    //   if (cards != null) {
    //     try {
    //       final List<BrazeContentCardWeb> parsedCards = cards.map((e) {
    //         final map = Map<String, dynamic>.from(e);
    //         final BrazeContentCardWeb parsedResult = BrazeContentCardWeb.fromJson(map);
    //         return parsedResult;
    //       }).toList();
    //       controller.add(parsedCards);
    //     } catch (e) {
    //       //TODO: log implementation, this means we cannot parse data in corrent way or response structure changed
    //       log(e.toString());
    //     }
    //   }
    // }));

    controller = StreamController<List<BrazeContentCardWeb>>.broadcast(
      onCancel: () {
        controller.close();
      },
    );

    return controller.stream;
  }

  /// request content cards updates
  static void requestContentCardsRefresh({Function? onSuccess, Function? onError}) {
    BrazePluginJS.requestContentCardsRefresh(
      allowInterop(() {
        onSuccess?.call();
      }),
      allowInterop(() {
        onError?.call();
      }),
    );
  }

  static bool logContentCardDismissed(BrazeContentCardWeb card) {
    // var cardJs = BrazeCardJs(
    //   id: card.id ?? '',
    //   // expiresAt: jsify(card.expiresAt.toIso8601String()),
    //   extras: card.extras,
    //   pinned: card.pinned,
    //   // updated: jsify(card.updated.toIso8601String()),
    //   viewed: true,
    // );
    // BrazePluginJS.logContentCardDismissed(card.id ?? '');
    Map map = {
      "ar": 1,
      "ca": 1702049609,
      "cl": false,
      "db": true,
      "dm": "",
      "ds": "ContetrwerweContetrwerweContetrwerweContetrwerweContetrwerweContetrwerwe",
      "e": {"hhhh": "wefwefewf"},
      "hhhh": "wefwefewf",
      "ea": 1702654409,
      "i":
          "https://braze-images.com/appboy/communication/marketing/content_cards_message_variations/images/65705a3e420133004b30fc83/9eedffcc4a3e86a8b2004173112f62a0eb7ae775/original.png?1701861956",
      "id":
          "NjU3MDVhM2U0MjAxMzMwMDRiMzBmYzdjXyRfY2M9ZjM2NDNmYmYtMjYzZS1hZWQ5LWUyM3QtMDlkY2Y4ODQ1YjUwJm12PTY1NzA1YTNlNDIwMTMzMDA0YjMwZmM4MyZwaT1jbXA=",
      "p": false,
      "tp": "short_news",
      "tt": "Contetrwerwe",
      "u": null,
      "uw": null,
      "v": false,
      "Yc": "ab-classic-card"
    };
    final cardJs = BrazeCardImpl.fromContentCardsJson(map);
    final card2 = JsObject.jsify(map);
    final cardJs2 = BrazeCardImpl.fromContentCardsJson(card2);

    // cardJs.dismissCard();
    // final card2 = BrazeCard.getInstance(cardJs);
    // final cardJsify = jsify(cardJs);
    return BrazePluginJS.logCardDismissal(cardJs2);
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
