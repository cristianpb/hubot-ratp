/*jslint node: true */
"use strict";

var soap = require('soap');
var http = require('http');

var service = {
    ws: {
        calc: {
            sumar : function(args) {
                var n = 1*args.a + 1*args.b;
                return { sumres : n };
            },

            multiplicar : function(args) {
                var n = args.a * args.b;
                return { mulres : n };
            }
        }
    }
};

var xml = require('fs').readFileSync('/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv.wsdl', 'utf8');

var server = http.createServer(function(request,response) {
    response.end("404: Not Found: "+request.url);
});

server.listen(8001);
soap.listen(server, '/wscalc1', xml);

//#soap = require('soap');
//#args = {line: {'id':'M13'}};
//#url = '/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv.wsdl';
//##var url = 'http://localhost:8001/wscalc1?wsdl';
//#soap.createClient(url, function(err, client) {
//#	if (err) throw err;
//#	//console.log(client.describe());
//#    client.getLines(args, function(err, result) {
//#        console.log(result);
//#    });
//#});
//
//###getMissionsNext(station={'line':{'id':'M13'}, 'name':'gaite'}, direction={'sens':'A'})
//##soap = require('soap')
//##url = '/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv.wsdl'
//##soap.createClient( url, (err, client) ->
//##  if err
//##    throw err
//##)
//##
//##getLines = (args) ->
//##  client.getLines args, (err, result) ->
//##    msg.reply "result"
//##    return
//##
//###exports = (robot) ->
//##module.exports = (robot) ->
//##  robot.respond /ratp (.+) (.+) (.+)/i, (msg) ->
//##    ligne        = msg.match[1]
//##    station      = msg.match[2]
//##    sens         = msg.match[3]
//##    msg.send "ligne #{ligne} sta #{station} and sens #{sens}"
//##
//##    args = line: 'id': ligne
//##    result = getLines(args)
//#
