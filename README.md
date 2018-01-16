# hubot-ratp

A hubot script to search for RATP informations in real time. 

Using ratp [API](https://dataratp2.opendatasoft.com/page/temps-reel/).

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
user1>> ratp in Monparnasse
hubot>> There
```

## NPM Module

https://www.npmjs.com/package/hubot-ratp
