hexsheff
================

Resources to help create hexagonal cartograms for Sheffield.

## Hex maps vs choropleths

Choropleth maps are a great way to illustrate differences in a city.
However, some of Sheffield is a part of a national park and the city’s
population density varies more than most cities. Typically, city
sub-areas are of approximately equal population sizes, which means
Sheffield sub-areas are of significantly different geographical sizes.
For Sheffield choropleths, the differences in geographical sizes can
detract from the main statistic of interest.

Hexagonal cartograms, or “hex maps”, are one alternative to choropleths.
They can still provide an indication of location, but mute differences
in geographical size.

ODI Leeds have done some interesting work on [hex maps
work](https://open-innovations.org/blog/2017-05-08-mapping-election-with-hexes).

## Building a hex map template

The process for creating the Local Area Committee hexes (which have the
same boundaries as the Adult Social Care localities):

1.  Drop the `data/lac_asc_xref.csv` file into the ODI Leeds [hex map
    builder](https://open-innovations.org/projects/hexmaps/builder.html),
    hexify, and save hexes as HexJson.
2.  Drop the `data/lac_asc.hexjson` file into Oli Hawkins [HexJSON
    Editor](https://olihawkins.com/project/hexjson-editor/), edit, and
    download as GeoJson to file `data/lac-asc-hex.geojson`.

The [HexJSON
format](https://open-innovations.org/projects/hexmaps/hexjson.html)
defined by ODI Leeds is a great idea. However, use of the format hasn’t
been huge, so we’ve stuck with GeoJson, which plays well with the
ggplot2 R package.

[geojson.io](https://geojson.io/) is useful for viewing and editing
GeoJson files.
