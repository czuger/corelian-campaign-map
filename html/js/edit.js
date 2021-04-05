/**
 * Created by ced on 05/04/2021.
 */


// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#main',
    data: { tokens: [] },
    methods: {
        onclick: function (event) {
            console.log(event);
            console.log(this.tokens);
            this.tokens = [{'id': 'foo'}]
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
