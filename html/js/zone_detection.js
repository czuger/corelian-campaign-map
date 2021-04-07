/**
 * Created by ced on 07/04/2021.
 */

const areas = [
    { top: 299, left: 375, zone: 'froz' },
    { top: 485, left: 424, zone: 'selonia' }
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