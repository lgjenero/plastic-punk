import 'package:flutter/foundation.dart';

final isWebMobile =
    kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

final isWebDesktop =
    kIsWeb && (defaultTargetPlatform != TargetPlatform.iOS && defaultTargetPlatform != TargetPlatform.android);

final isAndroid = defaultTargetPlatform == TargetPlatform.android;

final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

final isMobile = !kIsWeb && (isAndroid || isIOS);
