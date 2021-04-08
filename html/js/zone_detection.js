/**
 * Created by ced on 07/04/2021.
 */

const areas = [
    { top: 299, left: 375, zone: 'froz' },
    { top: 485, left: 424, zone: 'selonia' },
    { top: 692, left: 152, zone: 'crash_drift' },
    { top: 524, left: 630, zone: 'drall' },
    { top: 417, left: 885, zone: 'polanis' },
    { top: 622, left: 575, zone: 'corellia' },
    { top: 118, left: 800, zone: 'phemis' },
    { top: 681, left: 384, zone: 'talus' },
    { top: 846, left: 471, zone: 'tralus' },
];

const top_area_decal = 25;
const left_area_decal = 24;

function get_area(x, y){

    for (const area of areas){
        const center_top = area.top + top_area_decal;
        const center_left = area.left + left_area_decal;

        const top = y;
        const left = x;

        if(top >= center_top - top_area_decal && top <= center_top + top_area_decal &&
            left >= center_left - left_area_decal && left <= center_left + left_area_decal){

            return [area.zone, area.top, area.left];
        }
    }
}

function read_area(_area, status){

    for (const area of areas){
        if(area.zone === _area){
            style = 'top:' + (area.top) + 'px;left:' + (area.left) + 'px';
            return {pos: style, area: _area, status: status};
        }
    }
}
