require "polygonfy/version"
require "polygonfy/Point"
require "polygonfy/Polygon"

module Polygonfy
  def self.run
    if ARGV.length == 0
      puts "Use: polygonfy filename [id,x,y] [id,x,y] [..]"
      return
    end

    points = ARGV.length > 1 ? ARGV.drop(1) : STDIN.readline.split(' ')

    points.map! do |p|
      id, x, y = p.split(',')
      Point.new(id, x.to_i, y.to_i)
    end

    polygon = Polygon.new(points)

    File.open(ARGV[0], 'w') do |f|
      f.write(polygon.to_xml)
    end
  end
end
