
const String host = "http://127.0.0.1:8000/";

const Map<String, dynamic> baseHeaders = {};

class AuthEndpoint {
  String path;

  Method method;

  Map<String, dynamic> headers;

  Object body;

  AuthEndpoint(this.path, this.method, {Map<String, dynamic> extraHeaders}) {
    headers = baseHeaders;
    if (extraHeaders != null) {
      addHeaders(extraHeaders);
    }
  }

  void addHeaders(Map<String, dynamic> extraHeaders) {
    Map<String, dynamic> map = Map.from(baseHeaders);
    map.addAll(extraHeaders);
    headers = map;
  }

  void replaceInPath(String keyToReplace, String replacement) {
    path = path.replaceFirst(keyToReplace, replacement);
  }

  void addBody(Object data) {
    this.body = data;
  }

  @override
  String toString() {
    return 'Endpoint{host: $host, path: $path, method: $method, headers: $headers, body: $body}';
  }
}

enum Method { post, get, put, delete }

