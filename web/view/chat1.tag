<chat1>
    <div id="chat"  class="fixed" data-current-user="Art Ramadani" data-order-by-status="1" data-max-chat-history="25">

        <div class="chat-inner draggable">
            
            <h2 class="chat-header">
                <a href="#" class="chat-close"><i class="entypo-cancel"></i></a>

                <i class="entypo-users"></i> Chat
                <span class="badge badge-success is-hidden">0</span>
            </h2>

            <div class="chat-group" id="group-1">
                <strong>Favorites</strong>
                <a href="#" onclick={ open } each={ items } ><span class={ status.icon }></span> <em>{ name }</em></a>
                <!--
                <a href="#"><span class="user-status is-online"></span> <em>Nicholas R. Walker</em></a>
                <a href="#"><span class="user-status is-busy"></span> <em>Susan J. Best</em></a>
                <a href="#"><span class="user-status is-offline"></span> <em>Brandon S. Young</em></a>
                <a href="#"><span class="user-status is-idle"></span> <em>Fernando G. Olson</em></a>
                -->
            </div>

            <div class="chat-group" id="group-2">
                <strong>Work</strong>

                <a href="#"><span class="user-status is-offline"></span> <em>Robert J. Garcia</em></a>
                <a href="#" data-conversation-history="#sample_history_2"><span class="user-status is-offline"></span> <em>Daniel A. Pena</em></a>
                <a href="#"><span class="user-status is-busy"></span> <em>Rodrigo E. Lozano</em></a>
            </div>

            <div class="chat-group" id="group-3">
                <strong>Social</strong>
                <a href="#"><span class="user-status is-busy"></span> <em>Velma G. Pearson</em></a>
                <a href="#"><span class="user-status is-offline"></span> <em>Margaret R. Dedmon</em></a>
                <a href="#"><span class="user-status is-online"></span> <em>Kathleen M. Canales</em></a>
                <a href="#"><span class="user-status is-offline"></span> <em>Tracy J. Rodriguez</em></a>
            </div>
            
        </div>

        <!-- conversation template-->
        <div class="chat-conversation draggable" if={ message.isVisible }>

            <div class="conversation-header">
                <a href="#" onclick={ close } class="conversation-close"><i class="entypo-cancel"></i></a>

                <span class={ message.status.icon }></span>
                <span class="display-name">{ message.name }</span>
                <small>{ message.status.text }</small>
            </div>

            <ul class="conversation-body">
                <li class="odd">
                    <span class="user">Art Ramadani</span><p>Are you here?</p><span class="time">09:00</span>
                </li>
            </ul>

            <div class="chat-textarea">
                <textarea class="form-control autogrow" onkeydown={ sendMessage } placeholder="Type your message"></textarea>
            </div>
        </div>
         
    </div>
    <script>
        // isVisible message options
        this.message = {
            isVisible:false,
            name:'',
            status:{
                icon:'',
                text:''
            }
        } 
        

        // group item
        this.items = [
            {id:'1', name:'Catherine J. Watkins1',status:{icon:'user-status is-busy',text:'busy'}},
            {id:'2', name:'Catherine J. Watkins2',status:{icon:'user-status is-online',text:'online'}},
            {id:'3', name:'Catherine J. Watkins3',status:{icon:'user-status is-busy',text:'busy'}},
        ]

        /**
         * open message window
         *
         */
        open(e) {
            console.log('open',e.item)
            this.message = {
            isVisible:true,
            name:e.item.name,
            status:{
                    icon:e.item.status.icon,
                    text:e.item.status.text
                }
            } 

        }

        /**
         * close message window
         *
         */
        close(e) {
            console.log('close',e)
            this.message.isVisible = false
        }

        sendMessage(e){
            console.log('sendMessage',e)
            switch(e.keyCode){
                case 13: // send message
                    break
                case 27:
                    this.message.isVisible = false
                    break
                default: break     
            }
        }       
        
        this.on('mount', function() {
            console.log('mount','mount')
            // target elements with the "draggable" class
            interact('.draggable')
            .draggable({
                // enable inertial throwing
                inertia: true,
                // keep the element within the area of it's parent
                restrict: {
                restriction: "parent",
                endOnly: true,
                elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
                },
                // enable autoScroll
                autoScroll: true,

                // call this function on every dragmove event
                onmove: this.dragMoveListener,
                // call this function on every dragend event
                onend: function (event) {
                    console.log('onend','onend')
                }
            })
        })

        
        dragMoveListener (event) {
            var target = event.target,
                // keep the dragged position in the data-x/data-y attributes
                x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx,
                y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

            // translate the element
            target.style.webkitTransform =
            target.style.transform =
            'translate(' + x + 'px, ' + y + 'px)';

            // update the posiion attributes
            target.setAttribute('data-x', x);
            target.setAttribute('data-y', y);
        }
    </script>
</chat1>