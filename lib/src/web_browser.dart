import 'package:dio/dio.dart';
import 'package:mason_logger/mason_logger.dart';

import '../dwb.dart';
import 'browser_command.dart';

/// The main web browser class.
class WebBrowser {
  /// Create an instance.
  WebBrowser({
    required this.http,
    required this.logger,
    required this.commands,
    required this.convertHtml,
  });

  /// The HTTP client to use.
  final Dio http;

  /// The logger to use.
  final Logger logger;

  /// The commands to offer.
  final List<BrowserCommand> commands;

  /// The HTML converter to use.
  final String Function(String html) convertHtml;

  /// The current tab.
  BrowserTab? tab;

  /// Load [url].
  Future<void> get(final String url) async {
    final response = await http.get(url);
    final code = response.statusCode;
    if (code != 200) {
      tab = BrowserTab(url: url, contents: '!! Error !!: Status $code');
    } else {
      final data = response.data;
      if (data is String) {
        tab = BrowserTab(url: url, contents: convertHtml(data));
      } else {
        logger.err('Cannot handle data of type ${data.runtimeType}.');
      }
    }
  }

  /// Run commands until we quit.
  Future<void> run() async {
    command_parser:
    while (true) {
      final line = logger.prompt('> ');
      if (line.isNotEmpty) {
        final parts = line.split(' ');
        final commandName = parts.first;
        final arguments = parts.sublist(1);
        for (final command in commands) {
          if (command.aliases.contains(commandName) ||
              command.name.startsWith(commandName)) {
            try {
              await command.invoke(this, arguments);
              // ignore: avoid_catching_errors
            } on ArgumentError catch (e) {
              logger.err('${e.name}: ${e.message}');
            } on QuitBrowser {
              break command_parser;
            } on SilentError {
              continue; // No worries, be happy.
            }
            continue command_parser;
          }
        }
        logger.warn('Command not found: $commandName');
      }
    }
  }
}
