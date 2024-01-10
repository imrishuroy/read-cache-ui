import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/features/cache/domain/domain.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class CacheTile extends StatelessWidget {
  const CacheTile({
    required this.cache,
    required this.index,
    super.key,
  });
  final Cache? cache;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50,
          child: FadeInAnimation(
            child: ListTile(
              title: Text(cache?.title ?? '--'),
              subtitle: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    children: [
                      if (Validator.isValidLink(cache?.link))
                        TextSpan(
                          text: cache?.link ?? '-',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _launchURL(cache?.link),
                        ),
                      if (!Validator.isValidLink(cache?.link))
                        TextSpan(
                          text: cache?.link ?? '-',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              trailing: Text(
                cache?.createdAt != null
                    ? timeago.format(cache!.createdAt!)
                    : '',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || !Validator.isValidLink(url)) return;
    final url0 = Uri.parse(url);
    if (await launchUrl(url0)) {
    } else {
      throw 'Could not launch $url0';
    }
  }
}
