import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:braze_plugin_web/braze_plugin_web.dart';

/// Set the Braze API Key and Base URL with Dart Environment Variables
/// Run Args: --dart-define=apiKey=1234567890 --dart-define=baseUrl=sdk.iad-02.braze.com
void main() => runApp(MyApp());

const String _brazeApiKey = String.fromEnvironment('apiKey');
const String _brazeBaseUrl = String.fromEnvironment('baseUrl');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Braze Plugin for Web',
      home: BrazeWebExamplePage(),
    );
  }
}

class BrazeWebExamplePage extends StatefulWidget {
  @override
  BrazeWebExamplePageState createState() => new BrazeWebExamplePageState();
}

class BrazeWebExamplePageState extends State<BrazeWebExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braze Web Example'),
      ),
      body: Column(
        children: [
          TextButton(
            child: const Text('Initialize'),
            onPressed: () async {
              BrazeClient.instance.initialize(
                apiKey: _brazeApiKey,
                baseUrl: _brazeBaseUrl,
                automaticallyShowInAppMessages: true,
                enableLogging: true,
              );
            },
          ),
          TextButton(
            child: const Text('Identify'),
            onPressed: () async {
              BrazeClient.instance.identify('test-user');
            },
          ),
          TextButton(
            child: const Text('Set Custom Attribute'),
            onPressed: () async {
              BrazeClient.instance.setCustomAttribute('test_web_plugin', true);
            },
          ),
          TextButton(
            child: const Text('Set Custom Attributes'),
            onPressed: () async {
              BrazeClient.instance.setCustomAttributes({
                'test_web_plugin_1': 'Hi!',
                'test_web_plugin_2': 27,
              });
            },
          ),
          TextButton(
            child: const Text('Log Custom Event'),
            onPressed: () async {
              BrazeClient.instance.logCustomEvent(
                'test_web_plugin_event',
                jsonEncode({'prop1': false}),
              );
            },
          ),
        ],
      ),
    );
  }
}
