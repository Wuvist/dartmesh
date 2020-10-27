@JS()
library callable_function;

import 'package:js/js.dart';
import 'package:http/http.dart' as http;

// void main() async {
//   var url = 'https://google.com';
//   print(await http.read(url));
// }

/// Allows assigning a function to be callable from `window.functionName()`
@JS('fetchPubspec')
external set _fetchPubspec(void Function() f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void functionName();

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}

Future<String> fetchPubspec() async {
  var url = '/pubspec.yaml';
  var result = await http.read(url);
  return result;
}

Promise<String> _fetchPubspecWrap() {
  var myFuture = fetchPubspec();
  return new Promise<String>(allowInterop((resolve, reject) {
    myFuture.then(resolve, onError: reject);
  }));
}

void main() {
  _fetchPubspec = allowInterop(_fetchPubspecWrap);
}
