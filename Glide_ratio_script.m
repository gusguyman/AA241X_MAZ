%Latitude, Longitude, and Altitude at end of glide
alt2= 118.759002686;
lon2 = -122.1541747;
lat2 = 37.4011047;
%Latitude, Longitude, and Altitude at start of glide
alt1=146.208999634;
lon1 = -122.1543171;
lat1 = 37.4001599;
%Change in latitude, longitude, and altitude
d_lat = lat2-lat1;
d_lon = lon2-lon1;
d_alt = alt2-alt1;
%changes in feet
d_lon_ft = cos((lat1 + lat2)/2)*69.172*5280*d_lon;
d_lat_ft = d_lat * 69.172*5280;
%total change in horizontal distance in feet
d_ft = sqrt(d_lat_ft^2 + d_lon_ft^2);
%Glide ratio or L/D
glide_ratio = abs(d_ft/d_alt)