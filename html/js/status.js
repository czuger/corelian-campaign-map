/**
 * Created by ced on 08/04/2021.
 */


// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#status',
    data: { bases: [] },
    mounted: function () {
        // console.log(make_host('/'));

        const view_name = get_url_parameter('side');
        const key = get_url_parameter('key');

        axios
            .get(make_host('/'+view_name+'?key='+key))
            .then(response => {
                    console.log(response.data);

                    for (const d of response.data){
                        // console.log(d);
                        var a = read_area(d);
                        console.log(a);
                        this.bases.push(a);
                    }
                }
            )
    },
    updated: function () {
        this.$nextTick(function () {
            // Code that will run only after the
            // entire view has been re-rendered

            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl)
            })
        })
    },
    computed: {
        total_base: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += this.status_base_points(base.status)
            }

            return cumul;
        },
        total_location: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += base.construction;
            }

            return cumul;
        },
        total_repair: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += base.repair_yards;
            }

            return cumul;
        },
        total_diplomats: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += base.diplomats;
            }

            return cumul;
        },
        total_spynets: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += base.spynets;
            }

            return cumul;
        },
        total_skilled_spacers: function(){
            let cumul = 0;

            for(base of this.bases){
                cumul += base.skilled_spacers;
            }

            return cumul;
        }

    },
    methods: {
        base_points_details: function(base){
            // console.log(base);
            return this.status_base_points(base.status).toString() + ' + ' + base.construction.toString();
        },
        repair_total_detail: function(){
            // console.log(base);
            let thirty = 30;
            return thirty.toString() + ' + ' + this.total_repair.toString();
        },
        status_name: function(status){
            switch (status) {
                case 1:
                case 2:
                    return 'Base';
                break;

                case 3:
                    return 'Outpost';
                break;

                default:
                    return 'Inconnu';
            }
        },
        status_base_points: function(status){
            switch (status) {
                case 1:
                case 2:
                    return 25;
                    break;

                case 3:
                    return 5;
                    break;

                default:
                    return 0;
            }
        }
    }
});

$(function () {
})