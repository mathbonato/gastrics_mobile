const gastricsApiUrl = 'http://192.168.209.238:3002/gastrics/api';

prepareUrl<String> (String url) {
  return Uri.parse("$gastricsApiUrl$url");
}