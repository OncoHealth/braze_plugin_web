# braze_plugin_web

Unofficial Braze Plugin for Flutter for Web.

> [Braze](https://www.braze.com/) is a customer engagement platform used by businesses for multichannel marketing. You need a valid Braze account in order to use this plugin.


This package is a Flutter Web Plugin acting as a wrapper around the official Braze Web SDK using [JavaScript Interop](https://pub.dev/packages/js).

> Note: For Android and iOS, use the official [Braze Flutter SDK](https://pub.dev/packages/braze_plugin).


## Configuration

This plugin uses the [Braze Web SDK loaded from the Braze CDN](https://www.braze.com/docs/developer_guide/platform_integration_guides/web/initial_sdk_setup/#install-cdn).

The following script needs to be added to the `index.html` file (in the web folder).

``` html
  <script type="text/javascript">
    +function(a,p,P,b,y){a.braze={};a.brazeQueue=[];for(var s="BrazeSdkMetadata DeviceProperties Card Card.prototype.dismissCard Card.prototype.removeAllSubscriptions Card.prototype.removeSubscription Card.prototype.subscribeToClickedEvent Card.prototype.subscribeToDismissedEvent Card.fromContentCardsJson Banner CaptionedImage ClassicCard ControlCard ContentCards ContentCards.prototype.getUnviewedCardCount Feed Feed.prototype.getUnreadCardCount ControlMessage InAppMessage InAppMessage.SlideFrom InAppMessage.ClickAction InAppMessage.DismissType InAppMessage.OpenTarget InAppMessage.ImageStyle InAppMessage.Orientation InAppMessage.TextAlignment InAppMessage.CropType InAppMessage.prototype.closeMessage InAppMessage.prototype.removeAllSubscriptions InAppMessage.prototype.removeSubscription InAppMessage.prototype.subscribeToClickedEvent InAppMessage.prototype.subscribeToDismissedEvent InAppMessage.fromJson FullScreenMessage ModalMessage HtmlMessage SlideUpMessage User User.Genders User.NotificationSubscriptionTypes User.prototype.addAlias User.prototype.addToCustomAttributeArray User.prototype.addToSubscriptionGroup User.prototype.getUserId User.prototype.incrementCustomUserAttribute User.prototype.removeFromCustomAttributeArray User.prototype.removeFromSubscriptionGroup User.prototype.setCountry User.prototype.setCustomLocationAttribute User.prototype.setCustomUserAttribute User.prototype.setDateOfBirth User.prototype.setEmail User.prototype.setEmailNotificationSubscriptionType User.prototype.setFirstName User.prototype.setGender User.prototype.setHomeCity User.prototype.setLanguage User.prototype.setLastKnownLocation User.prototype.setLastName User.prototype.setPhoneNumber User.prototype.setPushNotificationSubscriptionType InAppMessageButton InAppMessageButton.prototype.removeAllSubscriptions InAppMessageButton.prototype.removeSubscription InAppMessageButton.prototype.subscribeToClickedEvent FeatureFlag FeatureFlag.prototype.getStringProperty FeatureFlag.prototype.getNumberProperty FeatureFlag.prototype.getBooleanProperty automaticallyShowInAppMessages destroyFeed hideContentCards showContentCards showFeed showInAppMessage toggleContentCards toggleFeed changeUser destroy getDeviceId initialize isPushBlocked isPushPermissionGranted isPushSupported logCardClick logCardDismissal logCardImpressions logContentCardImpressions logContentCardClick logContentCardsDisplayed logCustomEvent logFeedDisplayed logInAppMessageButtonClick logInAppMessageClick logInAppMessageHtmlClick logInAppMessageImpression logPurchase openSession requestPushPermission removeAllSubscriptions removeSubscription requestContentCardsRefresh requestFeedRefresh refreshFeatureFlags requestImmediateDataFlush enableSDK isDisabled setLogger setSdkAuthenticationSignature addSdkMetadata disableSDK subscribeToContentCardsUpdates subscribeToFeedUpdates subscribeToInAppMessage subscribeToSdkAuthenticationFailures toggleLogging unregisterPush wipeData handleBrazeAction subscribeToFeatureFlagsUpdates getAllFeatureFlags".split(" "),i=0;i<s.length;i++){for(var m=s[i],k=a.braze,l=m.split("."),j=0;j<l.length-1;j++)k=k[l[j]];k[l[j]]=(new Function("return function "+m.replace(/\./g,"_")+"(){window.brazeQueue.push(arguments); return true}"))()}window.braze.getCachedContentCards=function(){return new window.braze.ContentCards};window.braze.getCachedFeed=function(){return new window.braze.Feed};window.braze.getUser=function(){return new window.braze.User};window.braze.getFeatureFlag=function(){return new window.braze.FeatureFlag};(y=p.createElement(P)).type='text/javascript';
      y.src='https://js.appboycdn.com/web-sdk/4.7/braze.min.js';
      y.async=1;(b=p.getElementsByTagName(P)[0]).parentNode.insertBefore(y,b)
    }(window,document,'script');
  </script>
```
Get the latest version [loading-snippet.js](https://github.com/braze-inc/braze-web-sdk/blob/master/snippets/loading-snippet.js).



## Usage

``` dart
import 'package:braze_plugin_web/braze_plugin_web.dart';

BrazeClient.initialize(apiKey: _brazeApiKey, baseUrl: _brazeBaseUrl);
BrazeClient.identify('test-user');
BrazeClient.setCustomAttribute('test_web_plugin', true);
BrazeClient.setCustomAttributes({
                'test_web_plugin_1': 'Hi!',
                'test_web_plugin_2': 27,
              });
BrazeClient.logCustomEvent('test_web_plugin_event', jsonEncode({ 'prop1': false }));

```

## Sponsor

<a href="https://oncohealth.us/" target="_blank"><img src="https://oncohealth.us/wp-content/uploads/2023/02/OncoHealth-Horizontal.svg" alt="OncoHealth" height="50"></a>
