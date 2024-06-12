import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

/// Utility class for converting HTML to Markdown.
class HtmlToMarkdown {
  /// Allow constant.
  const HtmlToMarkdown({
    this.ignoredTags = const [
      'script',
      'html',
      'head',
      'div',
      'span',
      'style',
      'link',
    ],
  });

  /// Tags to ignore.
  ///
  /// For every entry in [ignoredTags], `''` will be returned when parsing any
  /// tag with the given name.
  final List<String> ignoredTags;

  /// Convert HTML string to Markdown string.
  String convert(final String html) {
    final document = html_parser.parse(html);
    final markdown = _convertNode(document.body!);
    return markdown;
  }

  /// Recursively convert HTML nodes to Markdown.
  String _convertNode(final Node node) {
    if (node is Text) {
      return node.text;
    }
    if (node is Element) {
      final tag = node.localName;
      if (ignoredTags.contains(tag)) {
        return '';
      }
      switch (tag) {
        case 'h1':
          return '# ${_convertChildren(node)}\n\n';
        case 'h2':
          return '## ${_convertChildren(node)}\n\n';
        case 'h3':
          return '### ${_convertChildren(node)}\n\n';
        case 'h4':
          return '#### ${_convertChildren(node)}\n\n';
        case 'h5':
          return '##### ${_convertChildren(node)}\n\n';
        case 'h6':
          return '###### ${_convertChildren(node)}\n\n';
        case 'p':
          return '${_convertChildren(node)}\n\n';
        case 'em':
          return '_${_convertChildren(node)}_';
        case 'strong':
          return '**${_convertChildren(node)}**';
        case 'ul':
          return '${_convertChildren(node)}\n';
        case 'ol':
          return '${_convertChildren(node)}\n';
        case 'li':
          return '- ${_convertChildren(node)}\n';
        case 'a':
          final href = node.attributes['href'];
          return '[$_convertChildren(node)]($href)';
        case 'img':
          final src = node.attributes['src'];
          final alt = node.attributes['alt'] ?? src ?? 'Image';
          return '![$alt]($src)';
        case 'blockquote':
          return '> ${_convertChildren(node)}\n\n';
        case 'code':
          return '`${_convertChildren(node)}`';
        case 'pre':
          return '```\n${_convertChildren(node)}\n```\n\n';
        case 'br':
          return '\n';
        case 'center':
          return '        ${_convertChildren(node)}';
        default:
          print('<$tag>');
          return _convertChildren(node);
      }
    }

    return '';
  }

  /// Convert all children of a node.
  String _convertChildren(final Node node) =>
      node.nodes.map(_convertNode).join();
}
