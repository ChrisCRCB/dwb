import 'package:dio/dio.dart';
import 'package:dwb/dwb.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main(final List<String> arguments) async {
  final dio = Dio();
  final logger = Logger();
  final browser = WebBrowser(
    http: dio,
    logger: logger,
    commands: [
      helpCommand,
      quitCommand,
      getCommand,
    ],
    convertHtml: const HtmlToMarkdown().convert,
  );
  if (arguments.isNotEmpty) {
    final url = arguments.first;
    await browser.get(url);
  }
  await browser.run();
}
