module ApplicationHelper
  def get_content_from(uri, selector='body')
    doc = Nokogiri::HTML(open(uri))
    doc.css('script, link').each { |node| node.remove }
    return doc.css(selector).text.split.join(" ")
  end
end