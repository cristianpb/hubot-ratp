# Description
#   A hubot script to obtain Paris transport times of RATP group.
#
# Configuration:
#   HUBOT_RATP_WSDL - Wsdl for soap request
#
# Commands:
#   hubot ratp line <ligne> <station> <sens (A|R)> - Returns line information
#   hubot ratp next <ligne> <station> <sens (A|R)> - Returns next time for a station
#
# Author:
#   cristianpb

soap = require('soap')
moment = require('moment')
url = process.env.HUBOT_RATP_WSDL
date_format = 'YYYYMMDDhh:mm'
client = null

soap.createClient( url, (err, cl) ->
  if err
    throw err
  else
    console.log "Soap connected"
    client = cl
)

module.exports = (robot) ->
  robot.respond /ratp line (.+) (.+) (.+)/i, (msg) ->
    ligne   = msg.match[1].toUpperCase( )
    station = msg.match[2]
    sens    = msg.match[3].toUpperCase( )
    msg.send "ligne #{ligne} sta #{station} and sens #{sens}"

    args = line: 'id': ligne
    client.getLines args, (err, result) ->
      if err
        throw err
      else
        described = result.return
        described = JSON.stringify(described, null, '\t')
        msg.reply "Result #{described}"

  # Get next train

  robot.respond /ratp next (.+) (.+) (.+)/i, (msg) ->
    ligne   = msg.match[1].toUpperCase( )
    station = msg.match[2]
    sens    = msg.match[3] || 'R'
    msg.send "ligne #{ligne} sta #{station} and sens #{sens}"

    args = 
      station:
        line:
          id:
            ligne
        name:
          station
      direction:
        sens:
          sens

    client.getMissionsNext args, (err, result) ->
      if err
        throw err
      else
        described = result.return
        perturbations = JSON.stringify(described['perturbations'], 'zero', '\t')
        mymsg = 'There are ' + perturbations + ' perturbations\n'
        for value in described['missions']
          mymsg += "Direction #{value['direction']['name']} "
          mymsg += "next in #{value['stationsMessages']} "
          mydate = moment(value['stationsDates'].toString(), date_format).format("H:mm")
          mymsg += "at #{mydate} \n"
        msg.send mymsg
