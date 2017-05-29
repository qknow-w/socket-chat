/**
 * Filename: /home/wei/Desktop/chat/app.js
 * Path: /home/wei/Desktop/chat
 * Created Date: Mon May 29 2017
 * Author: wei
 *
 * Copyright (c) 2017 Your Company
 */

const app = require('http').createServer(handlle)
const io = require('socket.io').listen(app)
const fs = require('fs')
const path = require('path')

app.listen(8181)
function handlle (req, res) {
  fs.readFile(path.join(__dirname) + '/index.html', (err, data) => {
    if (err) {
      res.writeHead(500)
      return res.end('Error loading index.html')
    }

    res.writeHead(200)
    res.end(data)
  })
}

io.sockets.on('connection', (socket) => {
  socket.emit('news', {hello: 'world'})
  socket.on('my other event', (data) => {
    console.log(data)
  })
})
