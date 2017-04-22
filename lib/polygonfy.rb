require "polygonfy/version"
require "polygonfy/point"
require "nokogiri"

module Polygonfy
  MARGIN = 12
  STYLES = {
    polygon: "fill:#4f9bff; stroke:#216cce; stroke-width:1; opacity:0.5",
    circle: "fill:orange"
  }

  def self.point_title(array, i)
    prev_point = array[i - 1].id
    next_point = array[(i + 1) % array.size].id
    curr_point = "#{array[i].x}, #{array[i].y}"

    "#{prev_point} (#{curr_point}) #{next_point}"
  end

  def self.run
    if ARGV.length == 0
      puts "Use: polygonfy filename [id,x,y] [id,x,y] [..]"
      return
    end

    filename = ARGV[0]

    points = ARGV.length > 1 ? ARGV.drop(1) : STDIN.readline.split(' ')

    points.map! do |p|
      id, x, y = p.split(',')
      Point.new(id, x.to_i + MARGIN, y.to_i + MARGIN)
    end

    xmlns  = "http://www.w3.org/2000/svg"
    width  = points.map(&:x).max + MARGIN
    height = points.map(&:y).max + MARGIN

    polygon_points = points.map { |p| "#{p.x},#{p.y}" }.join(' ')

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.svg(xmlns: xmlns, width: width, height: height) {
        xml.polygon(style: STYLES[:polygon], points: polygon_points)
        xml.g {
          points.each_with_index do |p, i|
            xml.circle(style: STYLES[:circle], cx: p.x, cy: p.y, r: "12")
            xml.text_(x: p.x, y: p.y + 5, 'text-anchor': 'middle') {
              xml.text(p.id)
              xml.title {
                xml.text(point_title(points, i))
              }
            }
          end
        }
      }
    end

    File.open(filename, 'w') do |f|
      f.write(builder.to_xml)
    end
  end
end
