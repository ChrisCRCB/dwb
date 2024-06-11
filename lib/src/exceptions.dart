/// Tell the browser to quit.
class QuitBrowser implements Exception {
  /// Create an instance.
  const QuitBrowser();
}

/// A silent error which should be ignored.
class SilentError implements Exception {
  /// Constant constructor.
  const SilentError({
    required this.message,
  });

  /// The message to show.
  final String? message;
}
