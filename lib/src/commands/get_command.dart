import '../../dwb.dart';
import '../browser_command.dart';

/// The get command.
final getCommand = BrowserCommand(
  name: 'get',
  description: 'Get a page.',
  invoke: (final browser, final arguments) async {
    if (arguments.length != 1) {
      throw const SilentError(message: 'Exactly one URL must be supplied.');
    }
    await browser.get(arguments.single);
  },
);
