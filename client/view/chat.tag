<chat>
  <button class="weui-btn weui-btn_primary" onclick={ join }>Join</button>

    <div class="page__bd" >
        <div class="weui-flex" each={ items }>
            <div class="weui-flex__item">
                <div class={ 1 ? "weui-cell__bd":"weui-cell__ft"}>
                    <p>{ content }</p>
                </div>
            </div>
        </div>
    </div>

    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__hd"><label for="" class="weui-label">message</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input" ref="input" value={ content }  placeholder="please write message" >
            </div>
        </div>

        <div class="weui-btn-area">
            <button class="weui-btn weui-btn_primary"  onclick={ send } >{ opts.send }</button>
        </div>
    </div>


    <script>
        this.items =  [
            { userid: 1, username: 'a' , content: 'hello a' },
            { userid: 2, username: 'b' , content: 'hello b' },
            { userid: 3, username: 'c' , content: 'hello c' }
        ]

        this.socket = null
        this.content = ''

        send(){
            console.log('send','send')
            console.log('content',this.refs.input.value)
            this.connect()
            let body = {
                username: 'd' , 
                content: 'world' 
            }
            this.socket.emit('public message', body)
           // riot.update();
        }

        join(){
            console.log('join','join')
            if(!this.socket){

            }
            this.connect()
			//告诉服务器端有用户登录
			this.socket.emit('login', {userid:Date.parse(new Date()), username:'wei'});
		    //监听新用户登录
            this.socket.on('login', function(o){
                console.log('login',o)
                //	CHAT.updateSysMsg(o, 'login');	
            });
            //监听消息发送
            let lelf = this
            this.socket.on('public message', function(obj){
                console.log('obj',obj)
                lelf.items.push(obj)  
                riot.update()
            })          	
        }

        connect (){
            if(!this.socket){
                this.socket = io.connect('http://localhost:8181')
                return 
            }
            
            this.socket = io.connect('http://localhost:8181')
            //连接websocket后端服务器
            
        }

    </script>        
</chat>


