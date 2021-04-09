/**
 * Created by ced on 08/04/2021.
 */


// L'objet est ajouté à une instance de Vue
var vm = new Vue({
    el: '#status',
    data: { bases: [], base_total: 0, area_total: 0, repair: 30 },
    mounted: function () {
        // console.log(make_host('/'));

        axios
            .get(make_host('/'))
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
    methods: {
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
        },
        cumul_method: function(base_status, location_points, repair_points){
            this.base_total += this.status_base_points(base_status);
            this.area_total += location_points;
            this.repair += repair_points;
        }
    }
});