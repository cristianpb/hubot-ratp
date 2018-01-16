//var easysoap = require('easysoap');
//var params = {
//	host   : 'http://opendata-tr.ratp.fr/wsiv/services/Wsiv',
//	path   : 'file://',
//	wsdl   : '/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv?wsdl',
//	// set soap headers (optional)
//	//headers: [{
//	//	'name'     : 'item_name',
//	//	'value'    : 'item_value',
//	//	'namespace': 'item_namespace'
//	//}]
//}
//var soapClient = easysoap.createClient(params);
//
//soapClient.getAllFunctions()
//        	.then((functionArray) => { console.log(functionArray); })
//			.catch((err) => { throw new Error(err); });
//

var soap = require('soap');
var args = {line: {'id':'M13'}};
var url = '/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv.wsdl';
//var url = 'http://localhost:8001/wscalc1?wsdl';
soap.createClient(url, function(err, client) {
	if (err) throw err;
	//console.log(client.describe());
    client.getLines(args, function(err, result) {
        console.log(result);
    });
});


//var soap = require('soap');
//var url = 'file:///Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv?wsdl';
////var args = {name: 'value'};
////var params = {wsdl_headers : {'content-type': 'application/soap+xml'} };
//var params = {wsdl_headers : {'content-type': 'application/soap+xml'} };
//soap.createClient(url,params, function(err, client) {
//    client.getLines(args, function(err, result) {
//        console.log(result);
//    });
//});
//

///////
/////var request = require('request');
/////var xml = ` <soapenv:Envelope
/////xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
/////xmlns:xsd="http://wsiv.ratp.fr/xsd" xmlns:wsiv="http://wsiv.ratp.fr">
/////<soapenv:Header/> <soapenv:Body> <wsiv:getLines> <wsiv:line>
/////<xsd:id>RB</xsd:id> </wsiv:line> </wsiv:getLines> </soapenv:Body>
/////</soapenv:Envelope> `
/////
/////var options = {
/////  url: 'http://opendata-tr.ratp.fr/wsiv/services/Wsiv',
/////  method: 'POST',
/////  body: xml,
/////  headers: {'content-type': 'text/xml;charset=UTF-8', "SOAPAction":"getLines"}
/////};
/////
/////let callback = (error, response, body) => {
/////  if (!error && response.statusCode == 200) {
/////    console.log('Raw result', body);
/////    var xml2js = require('xml2js');
/////    var parser = new xml2js.Parser({explicitArray: false, trim: true});
/////    parser.parseString(body, (err, result) => {
/////      console.log('JSON result', result);
/////    });
/////  };
/////  console.log('E', response.statusCode, response.statusMessage);  
/////};
/////request(options, callback);
