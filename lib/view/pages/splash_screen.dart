import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:translate_it/controller/navigator_controller.dart';
import 'package:translate_it/core/theme/theme_provider.dart';
import 'package:translate_it/view/pages/translate_page.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(themeProvider.notifier).initTheme();
      Future.delayed(
        const Duration(seconds: 3),
        () {
          navPush(context, const TranslatePage());
        },
      );
      return null;
    }, []);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/ic_get_translated_png.png',
              width: 80,
            ),
            const Text(
              '\nGet translated anything',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
