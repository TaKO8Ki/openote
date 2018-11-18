module ArticlesHelper
  def add_id_and_class_to_markdown(content)
    each_element = Nokogiri::HTML.parse(content)
    headings = each_element.css(".markdown_heading")

    td_in_table = each_element.css("td")
    th_in_table = each_element.css("th")

    id_count = 1
    headings.each do |heading|
      heading["id"] = "chapter_#{id_count}"
      id_count += 1
    end

    td_in_table.each do |td|
      td["class"] = "markdown_td"
    end

    th_in_table.each do |th|
      th["class"] = "markdown_th"
    end

    return each_element
  end

end
