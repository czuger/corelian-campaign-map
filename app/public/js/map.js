/**
 * Created by ced on 05/04/2021.
 */

var tokens_hash = null;
var token_id = 999999999;

Vue.component('base-img', {
    data: function () {
        return { pic_status: null }
    },
    props: ['pos', 'index', 'area', 'pic_status_init', 'rebels_edit_view', 'owner'],
    template: '<img class="base-class" :src="pic_path" :style="pos" v-on:click="change_status">',
    methods: {
        change_status: function (event) {
            console.log('change_status');

            const side = $('#side').val();

            console.log(`${side} === ${this.owner}`)

            if( side === this.owner){
                let index = tokens_hash.cycle.findIndex(e => e === this.pic_status);

                if(index >= tokens_hash.cycle.length-1){
                    this.pic_status = tokens_hash.cycle[0];
                }
                else{
                    this.pic_status = tokens_hash.cycle[index+1];
                }

                const campaign_id = $('#campaign_id').val();

                const url = `/map/${campaign_id}/set_position/${this.area}/${this.pic_status}`;
                $.post( url );

                if(this.pic_status === 'empty'){
                    main_vue.remove_token(this.area);
                }
            }
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
var main_vue = new Vue({
    el: '#main',
    data: { tokens: [] },
    mounted: function () {
        const campaign_id = $('#campaign_id').val();
        tokens_hash = JSON.parse($('#tokens_hash').val());

        for (const d of tokens_hash.tokens){
            let a = read_area(d);
            this.tokens.push(a);
        }
    },
    methods: {
        remove_token: function (location){
            let new_tokens = [];

            console.log('remove_tokens');
            console.log(this.tokens);

            for(token of this.tokens){

                console.log(token);
                console.log(`${token.area} != ${location}`);

                if(token.area != location)
                    new_tokens.push(token);
            }

            console.log(new_tokens);
            this.tokens = new_tokens;
        },
        onclick: function (event) {
            const side = $('#side').val();

            if(side){
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

                if(area_data){
                    const location = area_data[0];
                    const status = tokens_hash.cycle[0];

                    // need to remove the vuejs element on deletion.
                    this.tokens.push({pos: style, area: location, status: status, id: token_id, owner: side});
                    token_id += 1;

                    if(area_data)
                    {
                        const campaign_id = $('#campaign_id').val();

                        const url = `/map/${campaign_id}/set_position/${location}/${status}`;
                        $.post( url );
                    }
                }
            }
        }
    }
});