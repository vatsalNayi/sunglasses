convertHtmlText(String htmlText) {
  String convertedText =
      htmlText.replaceAll('&lt;p&gt;', '').replaceAll('&lt;/p&gt;', '');
  return convertedText;
}
