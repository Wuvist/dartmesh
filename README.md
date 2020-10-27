# dartmesh

mini POC to show:
* calling dart function from JS
* dart perform async HTTP request
* js code use await to obtain result

`index.js` is generated from `main.dart`:

```bash
dart2js -o index.js main.dart
```

## run

Host root folder in http, like:

```bash
python3 -m http.server
```

Visit in browser: `http://localhost:8000/`
