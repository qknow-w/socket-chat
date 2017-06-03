 <join>
    <button class="weui-btn weui-btn_primary" onclick={ join }>{ opts.title }</button>
    <script>
        join(){
            console.log('join','join')
            window.socket = io.connect('http://localhost:8181')
            //连接websocket后端服务器
			socket = io.connect('ws://realtime.plhwin.com:3000');
			//告诉服务器端有用户登录
			socket.emit('login', {userid:Date.parse(new Date()), username:'wei'});
		    //监听新用户登录
            socket.on('login', function(o){
                //	CHAT.updateSysMsg(o, 'login');	
            });	
        }


    </script>
 </join>

