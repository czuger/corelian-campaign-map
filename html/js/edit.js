/**
 * Created by ced on 05/04/2021.
 */

var imperial_view = null;

Vue.component('base-img', {
    data: function () {
        return { pic_status: null }
    },
    props: ['pos', 'index', 'area', 'pic_status_init', 'imperial_view'],
    template: '<img class="base-class" :src="pic_path" :style="pos" v-on:click="change_status">',
    methods: {
        change_status: function (event) {
            if(!imperial_view){
                this.pic_status += 1;

                // console.log(this._uid, this.pic_status);

                if (this.pic_status >= 5) {
                    // Vue.delete(vm.tokens, this.index);
                    $.post(make_host('/delete_position'),
                        {location: this.area, status: this.pic_status});
                }else
                {
                    $.post(make_host('/modify_position'),
                        {location: this.area, status: this.pic_status});
                }
            }
        }
    },
    computed: {
        pic_path: function(){
            switch (this.pic_status) {
                case 1:
                    return 'pics/ImperialBase_sticker.png';
                    break;

                case 2:
                    if(imperial_view == 'true'){
                        return 'pics/RebelPresence_sticker.png';
                    }else{
                        return 'pics/RebelBase_sticker.png';
                    }

                    break;

                case 3:
                    if(imperial_view == 'true'){
                        return 'pics/RebelPresence_sticker.png';
                    }else{
                        return 'pics/RebelOutpost_sticker.png';
                    }

                    break;

                case 4:
                    return 'pics/PresenceDestroyed_sticker.png';
                    break;

                // default:
                //     console.log(`Unknown pic status ${this.pic_status}`);
            }
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
        // console.log(make_host('/'));

        axios
            .get(make_host('/'))
            .then(response => {
                // console.log(response.data);

                for (const d of response.data){
                    // console.log(d);
                    var a = read_area(d.location, d.status);
                    // console.log(a);
                    this.tokens.push(a);
                }
            }
        )
    },
    created: function () {
        imperial_view = get_url_parameter('imperial');
    },
    methods: {
        onclick: function (event) {
            if(!imperial_view)
            {
                var area_data = get_area(event.offsetX, event.offsetY);

                if(area_data){
                    const y = area_data[1];
                    const x = area_data[2];
                    var style = 'top:' + (y) + 'px;left:' + (x) + 'px';
                }
                else{
                    const x = event.offsetX;
                    const y = event.offsetY;
                    var style = 'top:' + (y - 21) + 'px;left:' + (x - 21) + 'px';
                    area_data = [];
                }

                // console.log(style);
                this.tokens.push({pos: style, area: area_data[0], status: 1})

                if(area_data)
                {
                    $.post( make_host('/add_position'), { location: area_data[0], status: 1 } );
                }
            }
        }
    }
});