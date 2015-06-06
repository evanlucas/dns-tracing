# dns-tracing

Trace dns lookups for node


**NOTE: Still a WIP**

## Install

```bash
$ npm install evanlucas/dns-tracing
```

## Usage with iojs v2.x

```js
var net = require('net')
var lookup = require('dns-tracing')

var client = net.connect({
  host: '127.0.0.1'
, port: 8000
, lookup: lookup
})
```

Run `node-dns.d` to see dns lookups

## Author

Evan Lucas

## License

MIT (See `LICENSE` for more info)
