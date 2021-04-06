/**
 * Created by ced on 05/04/2021.
 */

Vue.component('base-img', {
    data: function () {
        return {
            pic_path: 'pics/ImperialBase_sticker.png',
            pic_status: 1
        }
    },
    props: ['pos'],
    template: '<img class="base-class" :src="pic_path" :style="pos" v-on:click="change_status">',
    methods: {
        change_status: function (event) {
            switch (this.pic_status) {
                case 1:
                    this.pic_path =  'pics/RebelPresence_sticker.png';
                    this.pic_status =  2;

                    break;
                case 2:
                    this.pic_path =  'pics/RebelPresence_sticker.png';
                    this.pic_status =  3;

                    break;

                case 3:
                    this.pic_path =  'pics/PresenceDestroyed_sticker.png';

                    break;

                default:
                    console.log(`Unknown pic status ${this.pic_status}`);
            }
        }
    }
})

// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#main',
    data: { tokens: [] },
    methods: {
        onclick: function (event) {
            // console.log(event);
            // console.log(this.tokens);
            // console.log(event.clientX, event.clientY);
            var x = event.offsetX;
            var y = event.offsetY;
            var style = 'top:' + (y - 21) + 'px;left:' + (x - 21) + 'px';
            // console.log(style);
            this.tokens.push({pos: style})
        }
    }
})

$(document).ready(function() {
    // $( "#main" ).click(function(event) {
    //     console.log(event.pageX, event.pageY);
    //     console.log(vm.data);
    //     // vm.data.tokens.appenc({'id': 'foo'})
    // });
});
