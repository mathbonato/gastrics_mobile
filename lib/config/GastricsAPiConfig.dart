const gastricsApiUrl = 'http://192.168.1.107:3002/gastrics/api';

prepareUrl<String> (String url) {
  return Uri.parse("$gastricsApiUrl$url");
}