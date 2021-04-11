import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencv_awesome/opencv_awesome.dart';

void main() {
  const MethodChannel channel = MethodChannel('opencv_awesome');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OpencvAwesome.platformVersion, '42');
  });
}
