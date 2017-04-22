# Polygonfy

Draw an SVG polygon easily from the command line.

## Installation

    $ gem install polygonfy

## Usage

format:

    $ polygonfy FILENAME ID,X,Y ID,X,Y ID,X,Y ...

in terminal:

    $ polygonfy mymap.svg 1,00,0 2,100.50,100.50 3,0,200.70

  1. "mymap.svg" is output file;
  2. others parameters are points in (ID,X,Y) format

You can also use with pipe operator:

    $ myowntask | polygonfy mymap.svg

  1. Since "myowntask" returns formated points in STDOUT

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

