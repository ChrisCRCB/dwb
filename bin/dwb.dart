import 'package:dio/dio.dart';
import 'package:dwb/src/browser_command.dart';
import 'package:dwb/src/html_to_markdown.dart';
import 'package:dwb/src/web_browser.dart';
import 'package:mason_logger/mason_logger.dart';

Future<void> main(final List<String> arguments) async {
  final dio = Dio();
  final logger = Logger();
  final browser = WebBrowser(
    http: dio,
    logger: logger,
    commands: [
      BrowserCommand(
        name: 'help',
        description: 'Get help on the supported commands.',
        invoke: (final browser, final arguments) {
          for (final command in browser.commands) {
            if (arguments.isEmpty || command.name.startsWith(arguments.first)) {
              logger
                ..info('    ${command.name}')
                ..info(command.description)
                ..info('Aliases: ${command.aliases.join(" | ")}');
            }
          }
        },
        aliases: ['?'],
      ),
    ],
    convertHtml: const HtmlToMarkdown().convert,
  );
  if (arguments.isNotEmpty) {
    final url = arguments.first;
    await browser.get(url);
  }
  await browser.run();
}
