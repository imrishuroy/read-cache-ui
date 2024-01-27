import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentRichText extends StatelessWidget {
  const ContentRichText({
    required this.content,
    super.key,
  });

  final String? content;

  @override
  Widget build(BuildContext context) {
    return content == null || content!.isEmpty
        ? const SizedBox.shrink()
        : RichText(
            text: TextSpan(
              children: [
                for (final word in content!.split(' '))
                  word.startsWith('http')
                      ? TextSpan(
                          text: '$word ',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _launchURL(word),
                        )
                      : TextSpan(
                          text: '$word ',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
              ],
            ),
          );
  }

  // bool _isUrl(String word) {
  //   return Uri.tryParse(word)?.hasAbsolutePath ?? false;
  // }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
