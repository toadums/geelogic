express = require 'express'
http = require 'http'
readline = require 'readline'
async = require 'async'
needle = require 'needle'

root.items = [0,1,2]

Routes = require './routes'

port = 3000

app = express()

server = http.createServer app

app.use express.bodyParser()

routes = new Routes app

app.listen port
