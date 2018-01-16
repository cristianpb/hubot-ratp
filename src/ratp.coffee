# Description
#   A hubot script to search for velibs bikes in Paris
#
# Configuration:
#   HUBOT_GOOGLE_API_KEY - Google API to search the coordinates of the place
#
# Commands:
#   hubot velibs in <place> - Returns the numbers 
#
# Author:
#   cristianpb

soap = require('soap')
moment = require('moment')
url = '/Users/cperez/Downloads/ratp-wsiv-opendata/Wsiv.wsdl'
client = null

soap.createClient( url, (err, cl) ->
  if err
    throw err
  else
    console.log "Soap connected"
    client = cl
)

module.exports = (robot) ->
  # your code here
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
    sens    = msg.match[3].toUpperCase( )
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
          mymsg += "next in #{value['stationsMessages']} "
          console.log value['stationsDates'].toDateString()
          mydate = new Date(value['stationsDates'])
          mydate = mydate.toDateString()
          mymsg += "at #{mydate} \n"

        msg.send mymsg
