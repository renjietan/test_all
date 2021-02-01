import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_appclient/utils/sputils.dart';

//类似广告启动页
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 375, height: 812, allowFontScaling: false)
          ..init(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: FlutterLogo(size: 96),
        // child: proca,
      ),
    );
  }

  //倒计时
  void countDown() {
    var _duration = Duration(seconds: 2);
    new Future.delayed(_duration, goHomePage);
  }

// Future<void> precacheImage(
//   ImageProvider provider,
//   BuildContext context, {
//   Size size,
//   ImageErrorListener onError,
// }) {
//   final ImageConfiguration config = createLocalImageConfiguration(context, size: size);
//   final Completer<void> completer = Completer<void>();
//   final ImageStream stream = provider.resolve(config);
//   ImageStreamListener listener;
//   listener = ImageStreamListener(
//     (ImageInfo image, bool sync) {
//       if (!completer.isCompleted) {
//         completer.complete();
//       }
//       // Give callers until at least the end of the frame to subscribe to the
//       // image stream.
//       // See ImageCache._liveImages
//       SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
//         stream.removeListener(listener);
//       });
//     },
//     onError: (dynamic exception, StackTrace stackTrace) {
//       if (!completer.isCompleted) {
//         completer.complete();
//       }
//       stream.removeListener(listener);
//       if (onError != null) {
//         onError(exception, stackTrace);
//       } else {
//         FlutterError.reportError(FlutterErrorDetails(
//           context: ErrorDescription('image failed to precache'),
//           library: 'image resource service',
//           exception: exception,
//           stack: stackTrace,
//           silent: true,
//         ));
//       }
//     },
//   );
//   stream.addListener(listener);
//   return completer.future;
// }
  //页面跳转
  void goHomePage() {
    String userinfo = SPUtils.getUserInfo();
    if (userinfo != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
