/**
 * Created by ced on 07/04/2021.
 */

const areas = [
    { top: 299, left: 375, zone: 'Froz', construction: 0, diplomats: true },
    { top: 485, left: 424, zone: 'Selonia', construction: 12, repair_yards: true },
    { top: 692, left: 152, zone: "Crash's drift", construction: 13, skilled_spacers: true },
    { top: 524, left: 630, zone: 'Drall', construction: 9, diplomats: true },
    { top: 417, left: 885, zone: 'Polanis', construction: 15 },
    { top: 622, left: 575, zone: 'Corellia', construction: 20, repair_yards: true },
    { top: 118, left: 800, zone: 'Phemis', construction: 2 },
    { top: 681, left: 384, zone: 'Talus', construction: 8, skilled_spacers: true },
    { top: 846, left: 471, zone: 'Tralus', construction: 8, skilled_spacers: true },
    { top: 761, left: 625, zone: 'Centerpoint', construction: 5, sypnets: true },
    { top: 858, left: 763, zone: 'Aurea', construction: 9, diplomats: true },
    { top: 937, left: 302, zone: 'Saberhing asteroid belt', construction: 16, repair_yards: true },
    { top: 1039, left: 712, zone: 'Sacorria', construction: 10 },
    { top: 635, left: 954, zone: "Raider's point", construction: 4, sypnets: true },
    { top: 1055, left: 991, zone: 'Vagrand', construction: 8, repair_yards: true },
    { top: 921, left: 1079, zone: 'Plympto', construction: 1, skilled_spacers: true },
    { top: 328, left: 1251, zone: 'Sileria', construction: 7, skilled_spacers: true },
    { top: 561, left: 1282, zone: 'Truuzdann', construction: 8 },
    { top: 694, left: 1252, zone: 'Corfai', construction: 19 },
    { top: 1031, left: 1315, zone: 'Xyquine II', construction: 1, repair_yards: true },
    { top: 160, left: 1484, zone: 'Talfaglio', construction: 6 },
    { top: 510, left: 1518, zone: 'Nubia', construction: 16, repair_yards: true },
    { top: 719, left: 1503, zone: 'Forvand', construction: 2, sypnets: true },
    { top: 1085, left: 1521, zone: 'Durd', construction: 17, skilled_spacers: true },
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
