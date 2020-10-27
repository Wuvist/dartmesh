@JS()
library callable_function;

import 'package:js/js.dart';
import 'package:http/http.dart' as http;

// void main() async {
//   var url = 'https://google.com';
//   print(await http.read(url));
// }

/// Allows assigning a function to be callable from `window.functionName()`
@JS('functionName')
external set _functionName(void Function() f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void functionName();

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));
  external Promise then(void onFulfilled(T result), [Function onRejected]);
}

Future<String> myFunction() async {
  var url = 'http://localhost:8000/pubspec.yaml';
  print(await http.read(url));
  return "done";
}

Promise<String> _someDartFunction() {
  var myFuture = myFunction();
  return new Promise<String>(allowInterop((resolve, reject) {
    myFuture.then(resolve, onError: reject);
  }));
}

void main() {
  _functionName = allowInterop(_someDartFunction);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}
