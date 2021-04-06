/**
 * Created by ced on 05/04/2021.
 */

Vue.component('base-img', {
    data: function () {
        return {
            count: 0
        }
    },
    props: ['pos'],
    template: '<img class="base-class" src="pics/ImperialBase_sticker.png" :style="pos">'
})



// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#main',
    data: { tokens: [] },
    methods: {
        onclick: function (event) {
            console.log(event);
            console.log(this.tokens);
            // console.log(event.clientX, event.clientY);
            var x = event.offsetX;
            var y = event.offsetY;
            var style = 'top:' + (y - 21) + 'px;left:' + (x - 21) + 'px';
            console.log(style);
            this.tokens.push({pos: style })
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
