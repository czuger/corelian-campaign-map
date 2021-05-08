/**
 * Created by ced on 05/04/2021.
 */

var tokens_hash = null;

Vue.component('base-img', {
    data: function () {
        return { pic_status: null }
    },
    props: ['pos', 'index', 'area', 'pic_status_init', 'rebels_edit_view'],
    template: '<img class="base-class" :src="pic_path" :style="pos" v-on:click="change_status">',
    methods: {
        change_status: function (event) {
            let index = tokens_hash.cycle.findIndex(e => e === this.pic_status);

            if(index >= tokens_hash.cycle.length-1){
                this.pic_status = tokens_hash.cycle[0];
            }
            else{
                this.pic_status = tokens_hash.cycle[index+1];
            }

            // if(rebels_edit_view){
            //     this.pic_status += 1;
            //
            //     // console.log(this._uid, this.pic_status);
            //     let key = get_url_parameter('key');
            //
            //     if (this.pic_status >= 5) {
            //         // Vue.delete(vm.tokens, this.index);
            //         $.post(make_host('/delete_position?key='+key),
            //             {location: this.area, status: this.pic_status});
            //     }else
            //     {
            //         $.post(make_host('/modify_position?key='+key),
            //             {location: this.area, status: this.pic_status});
            //     }
            // }
        }
    },
    computed: {
        pic_path: function(){
            return tokens_hash.pics_convert[this.pic_status];
        }
    },
    mounted: function () {
        this.pic_status = this.pic_status_init;
    },
});

// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#main',
    data: { tokens: [] },
    mounted: function () {
        const campaign_id = $('#campaign_id').val();
        tokens_hash = JSON.parse($('#tokens_hash').val());

        //             for (const d of response.data){
        //                 let a = read_area(d);
        //                 this.tokens.push(a);
        //             }
    },
    methods: {
        onclick: function (event) {
            var area_data = get_area(event.offsetX, event.offsetY);

            if(area_data){
                const y = area_data[1];
                const x = area_data[2];
                var style = 'top:' + (y) + 'px;left:' + (x) + 'px';
            }
            else{
                // Cant click outside points anymore.
                // const x = event.offsetX;
                // const y = event.offsetY;
                // var style = 'top:' + (y - 21) + 'px;left:' + (x - 21) + 'px';
                // area_data = [];
            }

            console.log(area_data);
            console.log(style);

            this.tokens.push(
                {
                    pos: style, area: area_data[0], status: tokens_hash.cycle[0]
                }
            )

            // if(area_data)
            // {
            //     $.post( make_host('/add_position?key='+key), { location: area_data[0], status: 1 } );
            // }
            }
        }
});