var dns = require('dns')
var d = require('dtrace-provider')
var dtp = d.createDTraceProvider('nodedns')

// lookupAddress, addressFamily
var startProbe = dtp.addProbe('lookup-start', "char *", "int")

// lookupAddress, ip, addressFamily
var endProbe = dtp.addProbe('lookup-end', "char *", "char *", "int")

dtp.enable()

module.exports = function(lookup) {
  lookup = lookup || dns.lookup
  return function(host, opts, cb) {
    startProbe.fire(function(p) {
      return [host. opts.family]
    })

    lookup(host, opts, function(err, ip, addressType) {
      if (err) return cb(err)
      endProbe.fire(function(p) {
        return [host, ip, addressType]
      })
      cb(null, ip, addressType)
    })
  }
}
