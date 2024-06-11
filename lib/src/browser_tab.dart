/// A tab in the browser.
class BrowserTab {
  /// Create an instance.
  const BrowserTab({
    required this.url,
    required this.contents,
  });

  /// The URL of this tab.
  final String url;

  /// The contents of the page.
  final String contents;
}
