/**
 * Created by ced on 05/04/2021.
 */

Vue.component('base-img', {
    data: function () {
        return {
            count: 0
        }
    },
    template: '<img src="pics/ImperialBase_sticker.png">'
})

// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#main',
    data: { tokens: [] },
    methods: {
        onclick: function (event) {
            console.log(event);
            console.log(this.tokens);
            this.tokens.push({id: 'foo'})
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
