require "nokogiri"

module Polygonfy
  class Polygon < Struct.new(:points)
    MARGIN = 12
    STYLES = {
      polygon: "fill:#4f9bff; stroke:#216cce; stroke-width:1; opacity:0.5",
      circle: "fill:orange"
    }

    def width
      points.map(&:x).max + (2 * MARGIN)
    end

    def height
      points.map(&:y).max + (2 * MARGIN)
    end

    def polygon_area
      points.map { |p| "#{p.x + MARGIN},#{height - (p.y + MARGIN)}" }.join(' ')
    end

    def point_title(i)
      prev_point = points[i - 1].id
      next_point = points[(i + 1) % points.size].id
      curr_point = "(#{points[i].x}, #{points[i].y})"

      "#{prev_point} #{curr_point} #{next_point}"
    end

    def point_x(point)
      point.x + MARGIN
    end

    def point_y(point)
      height - (point.y + MARGIN)
    end

    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.svg(xmlns: "http://www.w3.org/2000/svg", width: width, height: height) {
          xml.polygon(style: STYLES[:polygon], points: polygon_area)
          xml.g {
            points.each_with_index do |p, i|
              xml.circle(style: STYLES[:circle], cx: point_x(p), cy: point_y(p), r: "12")
              xml.text_(x: point_x(p), y: point_y(p) + 5, 'text-anchor': 'middle') {
                xml.text(p.id)
                xml.title {
                  xml.text(point_title(i))
                }
              }
            end
          }
        }
      end

      builder.to_xml
    end

  end
end