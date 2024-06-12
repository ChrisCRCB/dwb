import '../browser_command.dart';
import '../exceptions.dart';

/// The quit command.
final quitCommand = BrowserCommand(
  name: 'quit',
  description: 'Quit the browser',
  invoke: (final browser, final arguments) {
    browser.logger.info('Quitting.');
    throw const QuitBrowser();
  },
);
