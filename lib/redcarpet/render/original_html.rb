class Redcarpet::Render::OriginalHTML < Redcarpet::Render::HTML
  def header(text, level)
    '<h' + level.to_s + ' class="markdown_heading">' + "#{text}</h#{level}>"
  end

  def block_code(code, language)
    if language.present? && code.present?
      '<pre class="markdown_block_code">' + '<strong>' + '<code class="markdown_file_name">' + language.to_s + '</code></strong>' + '<code class="markdown_code">' + code.to_s  + "</code></pre>"
    elsif code.present?
      '<pre class="markdown_block_code_without_file_name">' + '<code class="markdown_code">' +  code.to_s + '</code>' + '</pre>'
    end
  end

  def paragraph(text)
    return '<div class="markdown_paragraph">' + text.to_s + '</div>'
  end

  def block_quote(quote)
    '<div class="markdown_quote">' + "#{quote}" + '</div>'
  end

  def list(contents, list_type)
    if list_type == :ordered
      type = "ol"
    elsif list_type == :unordered
      type = "ul"
    end
    return "<" + type + ">\n" + contents + '</' + type + ">\n"
  end

  def list_item(text, list_type)
    '<li class="markdown_list">' + text.to_s + '</li>'
  end

  def table(header, body)
    body = '<tbody>' + body + '</tbody>'
    '<table class="markdown_table">' + "\n" + "<thead>\n" + header.to_s + "</thead>\n" + body.to_s + "</table>\n"
  end

  def tablerow(content)
    '<tr>\n' + content.to_s + '</tr>\n'
  end

  def image(link, title, alt_text)
    if link == nil
      return text
    end
    out = '<p class="markdown_image"><img src="' + link.to_s + '" alt="' + alt_text.to_s + '"></p>'
    return out
  end

  def link(link, title, content)
    if link.nil?
      return content
    end
    output = '<a href="' + link + '"' + 'class="markdown_link"'
    if title.present?
      output += ' title="' + title + '"'
    end
    output += '>' + content + '</a>'
    return output
  end

  #redcarpetとmarked.jsでのリストの記法に少し異なりがあるので、統一するための修正
  def preprocess(whole_document)
    renew_article = whole_document.gsub("\n   - ", "\n     - ")
    renew_article = renew_article.gsub(/(\r\n){1,1}-/, "\r\n\r\n-")
    return renew_article.gsub("\n    - ", "\n     - ")
  end


end
