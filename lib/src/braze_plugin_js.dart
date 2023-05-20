@JS()
library braze;

import 'package:js/js.dart';

@JS("braze")
class BrazePluginJS {
  external static initialize(String apiKey, InitializationOptions? options);
  external static automaticallyShowInAppMessages();
  external static changeUser(String userId, String? signature);
  external static User getUser();
  external static logCustomEvent(String eventName, Map<String, dynamic>? eventProperties);
  external static openSession();
  external static requestImmediateDataFlush();
}


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
  // TODO: Complete
  external setCountry(String? country);
  external setCustomUserAttribute(String key, dynamic value, bool? merge);
}
