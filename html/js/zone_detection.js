/**
 * Created by ced on 07/04/2021.
 */

const areas = [
    { top: 299, left: 375, zone: 'froz', construction: 0, diplomats: true },
    { top: 485, left: 424, zone: 'selonia', construction: 12, repair_yards: true },
    { top: 692, left: 152, zone: 'crash_drift', construction: 13, skilled_spacers: true },
    { top: 524, left: 630, zone: 'drall', construction: 9, diplomats: true },
    { top: 417, left: 885, zone: 'polanis', construction: 15 },
    { top: 622, left: 575, zone: 'corellia', construction: 20, repair_yards: true },
    { top: 118, left: 800, zone: 'phemis', construction: 2 },
    { top: 681, left: 384, zone: 'talus', construction: 8, skilled_spacers: true },
    { top: 846, left: 471, zone: 'tralus', construction: 8, skilled_spacers: true },
    { top: 761, left: 625, zone: 'centerpoint', construction: 5, sypnets: true },
    { top: 858, left: 763, zone: 'aurea', construction: 9, diplomats: true },
    { top: 937, left: 302, zone: 'saberhing', construction: 16, repair_yards: true },
    { top: 1039, left: 712, zone: 'sacorria', construction: 10 },
    { top: 635, left: 954, zone: 'raiders_point', construction: 4, sypnets: true },
    { top: 1055, left: 991, zone: 'vagran', construction: 8, repair_yards: true },
    { top: 921, left: 1079, zone: 'plympto', construction: 1, skilled_spacers: true },
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
                repair_yards: (area.repair_yards ? 5 : 0),
                diplomats: (area.diplomats ? 1 : 0),
                spynets: (area.spynets ? 1 : 0),
                skilled_spacers: (area.skilled_spacers ? 1 : 0)
            };
        }
    }
}
