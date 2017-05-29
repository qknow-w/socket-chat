/**
 * Filename: /home/wei/Desktop/chat/app.js
 * Path: /home/wei/Desktop/chat
 * Created Date: Mon May 29 2017
 * Author: wei
 *
 * Copyright (c) 2017 Your Company
 */

const app = require('http').createServer()
const io = require('socket.io').listen(app)

app.listen(8181)

// online user
let onlineUsers = {}
// online count
let onlineCount = 0

io.sockets.on('connection', (socket) => {
  console.log('socket', socket.id)
  //   socket.emit('news', {hello: 'world'})
  //  // io.sockets.socket(socketid).emit('message', 'for your eyes only');
  //   socket.on('my other event', (data) => {
  //     console.log(data)
  //   })

  // 监听新用户加入
  socket.on('login', function (obj) {
    console.log('login', obj)
    // 将新加入用户的唯一标识当作socket的名称，后面退出的时候会用到
    socket.name = obj.userid
    // 检查在线列表，如果不在里面就加入
    if (!onlineUsers.hasOwnProperty(obj.userid)) {
      onlineUsers[obj.userid] = obj.username
      // 在线人数+1
      onlineCount++
    }
    // 向所有客户端广播用户加入
    io.emit('login', { onlineUsers: onlineUsers, onlineCount: onlineCount, user: obj })
    console.log(obj.username + '加入了聊天室')
  })

  // 监听用户退出
  socket.on('disconnect', function () {
    // 将退出的用户从在线列表中删除
    if (onlineUsers.hasOwnProperty(socket.name)) {
      // 退出用户的信息
      var obj = { userid: socket.name, username: onlineUsers[socket.name] }

      // 删除
      delete onlineUsers[socket.name]
      // 在线人数-1
      onlineCount--

      // 向所有客户端广播用户退出
      io.emit('logout', { onlineUsers: onlineUsers, onlineCount: onlineCount, user: obj })
      console.log(obj.username + '退出了聊天室')
    }
  })

  // 公共消息
  socket.on('public message', function (obj) {
    console.log('public message msg', obj)
    // let timestamp = new Date().getTime()
    // socket.broadcast.emit('public message', msg, timestamp)
    io.emit('public message', obj)
  })
})
