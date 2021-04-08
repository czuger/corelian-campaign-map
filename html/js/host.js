/**
 * Created by ced on 08/04/2021.
 */

var host_base = 'http://localhost:4567';

function make_host(path){
    return host_base + path
}

function get_url_parameter(sParam)
{
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++)
    {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam)
        {
            return sParameterName[1];
        }
    }
}