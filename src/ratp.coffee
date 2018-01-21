# Description
#   A hubot script to obtain Paris transport times of RATP group.
#
# Configuration:
#   HUBOT_RATP_WSDL - Wsdl for soap request
#
# Commands:
#   hubot ratp stations <line> - Returns stations for a line
#   hubot ratp next <line> <station> - Returns next transport times for a 
#   station
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


findNext = (args, msg) ->
  client.getMissionsNext args, (err, result) ->
    if err
      throw err
    else
      described = result.return
      mymsg = ''
      if described['perturbations']
        perturbations = JSON.stringify(described['perturbations'], 'zero', '\t')
        mymsg = 'There are ' + perturbations + ' perturbations\n'
      for value in described['missions']
        if value['perturbations']
          perturbations = JSON.stringify(value['perturbations'], 'zero', '\t')
          mymsg += "Perturbations #{perturbations} "
        mymsg += "Direction #{value['direction']['name']} "
        mymsg += "next in #{value['stationsMessages']} "
        mydate = moment(value['stationsDates'].toString(), date_format).format("H:mm")
        mymsg += "at #{mydate} \n"
      msg.send mymsg

module.exports = (robot) ->

  # Get station of a line

  robot.respond /ratp stations (.+)/i, (msg) ->
    ligne   = msg.match[1].toUpperCase( )
    msg.send "ligne #{ligne}"

    args = 
      station:
        line:
          id:
            ligne

    client.getStations args, (err, result) ->
      if err
        throw err
      else
        described = result.return
        mymsg = ''
        for value in described['stations']
            mymsg += "#{value['name']}\n"

        msg.reply mymsg

  # Get next transport time

  robot.respond /((R|A) )?ratp next (\w+) (.+)/i, (msg) ->
    sens    = msg.match[2] || 'RA'
    sens    = sens.split('')
    ligne   = msg.match[3].toUpperCase( )
    station = msg.match[4]
    msg.send "Ligne #{ligne} Station #{station} and Sens #{sens}"

    for value in sens
      args = 
        station:
          line:
            id:
              ligne
          name:
            station
        direction:
          sens:
            value

      findNext(args, msg)
