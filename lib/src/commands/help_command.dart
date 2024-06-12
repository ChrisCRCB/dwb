import '../browser_command.dart';

/// The help command.
final helpCommand = BrowserCommand(
  name: 'help',
  description: 'Get help on the supported commands.',
  invoke: (final browser, final arguments) {
    for (final command in browser.commands) {
      if (arguments.isEmpty || command.name.startsWith(arguments.first)) {
        final aliases = command.aliases.join(' | ');
        browser.logger
          ..info('    Command: ${command.name}')
          ..info(command.description)
          ..info('Aliases: ${aliases.isEmpty ? "None" : aliases}');
      }
    }
  },
  aliases: ['?'],
);
