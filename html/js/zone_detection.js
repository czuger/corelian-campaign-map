/**
 * Created by ced on 07/04/2021.
 */

const areas = [
    { top: 299, left: 375, zone: 'froz', construction: 0 },
    { top: 485, left: 424, zone: 'selonia', construction: 12, repair_yards: true },
    { top: 692, left: 152, zone: 'crash_drift', construction: 13 },
    { top: 524, left: 630, zone: 'drall', construction: 9 },
    { top: 417, left: 885, zone: 'polanis', construction: 15 },
    { top: 622, left: 575, zone: 'corellia', construction: 20, repair_yards: true },
    { top: 118, left: 800, zone: 'phemis', construction: 2 },
    { top: 681, left: 384, zone: 'talus', construction: 8 },
    { top: 846, left: 471, zone: 'tralus', construction: 8 },
    { top: 761, left: 625, zone: 'centerpoint', construction: 5 },
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

function read_area(_data){

    for (const area of areas){
        if(area.zone === _data.location){
            style = 'top:' + (area.top) + 'px;left:' + (area.left) + 'px';
            return {pos: style, area: _data.location, status: _data.status, construction: area.construction,
                db_id: _data.id, id: _data.id,
                repair_yards: (area.repair_yards ? 5 : 0)
            };
        }
    }
}
