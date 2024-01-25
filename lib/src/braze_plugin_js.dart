@JS()
library braze;

import 'package:js/js.dart';

@JS('JSON.parse')
external Object jsonParse(String obj);

@JS("braze")
class BrazePluginJS {
  external static initialize(String apiKey, InitializationOptions? options);

  external static automaticallyShowInAppMessages();

  external static changeUser(String userId, String? signature);

  external static User getUser();

  external static logCustomEvent(
    String eventName,
    Object? eventProperties,
  );

  external static openSession();

  external static requestImmediateDataFlush();

  external static subscribeToContentCardsUpdates(Function(ListBrazeCardsJsImpl cards) d);

  external static requestContentCardsRefresh<T>(Function() successCallback, Function() errorCallback);

  external static bool logCardDismissal(dynamic card);

  /// log card hided by id not implemented on braze sdk
  external static logContentCardClicked(String cardId);

  /// log card hided by id not implemented on braze sdk
  external static logContentCardDismissed(String cardId);
}

/// Provides further customization for initializing the [BrazeClient]
@JS()
@anonymous
class InitializationOptions {
  external bool? get allowCrawlerActivity;

  external set allowCrawlerActivity(bool? v);

  external bool? get allowUserSuppliedJavascript;

  external set allowUserSuppliedJavascript(bool? v);

  external String? get appVersion;

  external set appVersion(String? v);

  external String get baseUrl;

  external set baseUrl(String v);

  external String? get contentSecurityNonce;

  external set contentSecurityNonce(String? v);

  external bool? get disablePushTokenMaintenance;

  external set disablePushTokenMaintenance(bool? v);

  external bool? get doNotLoadFontAwesome;

  external set doNotLoadFontAwesome(bool? v);

  external bool? get enableLogging;

  external set enableLogging(bool? v);

  external List<String>? get devicePropertyAllowlist;

  external set devicePropertyAllowlist(List<String>? v);

  external bool? get enableSdkAuthentication;

  external set enableSdkAuthentication(bool? v);

  external int? get inAppMessageZIndex;

  external set inAppMessageZIndex(int? v);

  external String? get localization;

  external set localization(String? v);

  external bool? get manageServiceWorkerExternally;

  external set manageServiceWorkerExternally(bool? v);

  external int? get minimumIntervalBetweenTriggerActionsInSeconds;

  external set minimumIntervalBetweenTriggerActionsInSeconds(int? v);

  external bool? get noCookies;

  external set noCookies(bool? v);

  external bool? get openCardsInNewTab;

  external set openCardsInNewTab(bool? v);

  external bool? get openInAppMessagesInNewTab;

  external set openInAppMessagesInNewTab(bool? v);

  external bool? get requireExplicitInAppMessageDismissal;

  external set requireExplicitInAppMessageDismissal(bool? v);

  external String? get safariWebsitePushId;

  external set safariWebsitePushId(String? v);

  external String? get serviceWorkerLocation;

  external set serviceWorkerLocation(String? v);

  external int? get sessionTimeoutInSeconds;

  external set sessionTimeoutInSeconds(int? v);

  external factory InitializationOptions({
    bool? allowCrawlerActivity,
    bool? allowUserSuppliedJavascript,
    String? appVersion,
    String baseUrl,
    String? contentSecurityNonce,
    bool? disablePushTokenMaintenance,
    bool? doNotLoadFontAwesome,
    bool? enableLogging,
    List<String>? devicePropertyAllowlist,
    bool? enableSdkAuthentication,
    int? inAppMessageZIndex,
    String? localization,
    bool? manageServiceWorkerExternally,
    int? minimumIntervalBetweenTriggerActionsInSeconds,
    bool? noCookies,
    bool? openCardsInNewTab,
    bool? openInAppMessagesInNewTab,
    bool? requireExplicitInAppMessageDismissal,
    String? safariWebsitePushId,
    String? serviceWorkerLocation,
    int? sessionTimeoutInSeconds,
  });
}

@JS()
@anonymous
class User {
  external setCountry(String? country);

  external setCustomUserAttribute(String key, dynamic value, bool? merge);

  /// adopted from: [https://js.appboycdn.com/web-sdk/latest/doc/classes/braze.user.html#removefromsubscriptiongroup]
  external bool addToSubscriptionGroup(String subscriptionGroupId);

  external bool removeFromSubscriptionGroup(String subscriptionGroupId);
}

@JS()
@anonymous
class ListBrazeCardsJsImpl {
  external List<BrazeCardImpl> get cards;

  external bool full_sync;

  external int last_card_updated_at;
  external int last_full_sync_at;
}

@JS('Card')
@anonymous
abstract class BrazeCardImpl {
  external factory BrazeCardImpl({
    id,
    viewed,
    title,
    imageUrl,
    description,
    created,
    updated,
    categories,
    expiresAt,
    url,
    linkText,
    aspectRatio,
    extras,
    pinned,
    dismissible,
    clicked,
    Yc,
  });
  external String id;
  external bool? viewed;
  external String? title;
  external String? imageUrl;
  external String? description;
  external DateTime? created;
  external DateTime? updated;
  external List<String>? categories;
  external String? expiresAt;
  external String? url;
  external String? linkText;
  external double? aspectRatio;
  external Map<String, dynamic>? extras;
  external bool? pinned;
  external bool? dismissible;
  external bool? clicked;

  external String Yc;

  external dismissCard();
  external removeAllSubscriptions();
  external removeSubscription(String subscriptionGuid);
  external subscribeToClickedEvent(Function subscriber);
  external subscribeToDismissedEvent(Function subscriber);

  external static BrazeCardImpl fromContentCardsJson(dynamic data);
}
