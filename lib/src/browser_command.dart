import 'dart:async';

import '../dwb.dart';

/// A [WebBrowser] command.
class BrowserCommand {
  /// Create an instance.
  const BrowserCommand({
    required this.name,
    required this.description,
    required this.invoke,
    this.aliases = const [],
  });

  /// The name of this command.
  final String name;

  /// The description of this command.
  final String description;

  /// Any aliases for this command.
  final List<String> aliases;

  /// The function to run this command.
  final FutureOr<void> Function(WebBrowser browser, List<String> arguments)
      invoke;

  /// Returns the [browser] tab or throws [SilentError].
  BrowserTab getTab(
    final WebBrowser browser, {
    final String? message = 'No page has been loaded.',
  }) {
    final tab = browser.tab;
    if (tab == null) {
      throw SilentError(message: message);
    }
    return tab;
  }
}
