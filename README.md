# hubot-ratp

[![npm version](https://badge.fury.io/js/hubot-ratp.svg)](https://badge.fury.io/js/hubot-ratp) [![Build Status](https://travis-ci.org/cristianpb/hubot-ratp.svg?branch=master)](https://travis-ci.org/cristianpb/hubot-ratp)

A hubot script to search for RATP informations in real time. 

Using ratp [API](https://dataratp2.opendatasoft.com/page/temps-reel/).

Please note that you must validate your IP with the service in order to use the API.

See [`src/ratp.coffee`](src/ratp.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-ratp --save`

Then add **hubot-ratp** to your `external-scripts.json`:

```json
[
  "hubot-ratp"
]
```

## Sample Interaction

```
user>> myhubot ratp stations m14
myhubot> ligne M14
Olympiades
Biblioth_que Fran_ois Mitterrand
Cour Saint-Emilion
Bercy
Gare de Lyon
Ch_telet
Pyramides
Madeleine
Saint-Lazare

myhubot> myhubot ratp next m4 raspail
myhubot> Ligne M4 Station raspail and Sens R,A
Direction Porte de Clignancourt next in Train a l'approche at 11:01
Direction Porte de Clignancourt next in 2 mn at 11:03
Direction Porte de Clignancourt next in 3 mn at 11:04
Direction Porte de Clignancourt next in 5 mn at 11:06

Direction Mairie de Montrouge next in Train a l'approche at 11:01
Direction Mairie de Montrouge next in 2 mn at 11:03
Direction Mairie de Montrouge next in 6 mn at 11:07
Direction Mairie de Montrouge next in 8 mn at 11:09
```

## NPM Module

https://www.npmjs.com/package/hubot-ratp
