module HomeHelper
  def show_if_present(title, value)
    "<h3>#{title}</h3><p>#{value}</p>" unless value.nil? || value.length == 0
  end

  def link_if_present(title, value)
    show_if_present(title, "<a href='value'>#{value}</a>") unless value.nil? || value.length == 0
  end

  def paint_images(images)
    images.map { |image| "<a href='#{image}'><img src='#{image}' height='75' hspace='5' vspace='5' style='border: 1px solid #ddd;'/></a>" }.join
  end

  def links_to_li(links)
    links.map { |link| "<li><a href='#{link}'>#{link}</a></li>" }.join("\n")
  end
end
