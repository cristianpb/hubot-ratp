# hubot-ratp

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
user1>>  myhubot ratp next m6 nation R
hubot>> ligne M6 station nation sens R
There are undefined perturbations
Direction Nation next in 3 mn at 23:21
Direction Nation next in 5 mn at 23:23
Direction Nation next in 11 mn at 23:29
Direction Nation next in 16 mn at 23:34
```

## NPM Module

https://www.npmjs.com/package/hubot-ratp
