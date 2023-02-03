<!DOCTYPE html>
<html>
<meta charset="utf-8" />
<head>
 <link rel="stylesheet" href="https://unpkg.com/leaflet@1.6.0/dist/leaflet.css"/>
 <script src="https://unpkg.com/leaflet@1.6.0/dist/leaflet.js"></script>
<style>
 #map {
 width: 100%;
 height: 600px;
 box-shadow: 5px 5px 5px #888;
 }
 .info {
padding: 6px 8px;
font: 14px/16px Arial, Helvetica, sans-serif;
background: white;
background: rgba(255,255,255,0.8);
box-shadow: 0 0 15px rgba(0,0,0,0.2);
border-radius: 5px;
}
.info h2 {
margin: 0 0 5px;
color: #777;
}
</style>


</head>
 <body>
 <div id="map"></div>
<script>
var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
 attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a>'+ 'contributors',
maxZoom: 18
});


var elsalvador = L.tileLayer.wms("http://localhost:8080/geoserver/wms", {
 layers: 'elsalvador',
 format: 'image/png',
 transparent: true,
 attribution: "Centro Nacional de Registros"
});


//Añadimos los dos objetos
var baseMaps = {
 "OpenStreetMap": osm
};
var overlayMaps = {
 "ES": elsalvador 
 };

//Creamos el mapa
var map = L.map('map', {
center: new L.LatLng(13.65, -89.17),
zoom: 10,
//Añadimos las capas al mapa
layers: [osm, elsalvador]
});


// Insertando un título en el mapa
var title = L.control();
title.onAdd = function (map) {
 var div = L.DomUtil.create('div', 'info');
 div.innerHTML +=
 '<h2>Mapa ES</h2>Censo 2007';
 return div;
};
title.addTo(map);

// Insertando una leyenda en el mapa
var legend = L.control({position: 'bottomright'});
legend.onAdd = function (map) {
 var div = L.DomUtil.create('div', 'info legend');
 div.innerHTML +=
 '<img src="http://localhost:8080/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=amss" alt="legend" width="101" height="120">';
 return div;
};
legend.addTo(map);

//creamos el control de capas y lo añadimos al mapa
L.control.layers(baseMaps, overlayMaps, {collapsed:false}).addTo(map);
</script>
</body>
</html>