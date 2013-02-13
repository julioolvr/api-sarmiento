api-sarmiento
=============

Demo: http://api-sarmiento.herokuapp.com/

Toma la info de http://trenes.mininterior.gov.ar/apps/web_/ y la devuelve como JSON/JSONP.
Accediendo a `/` devuelve un hash donde cada elemento es una estación, que contiene un hash con dos arrays, uno con hasta 3 números que representan los minutos que faltan para que lleguen los próximos 3 trenes a Once, y otro con los próximos 3 trenes a Moreno.

Accediendo a `/estacion` devuelve directamente el hash con los minutos para la estación especificada.
