class Redcarpet::Render::OriginalHTML < Redcarpet::Render::HTML
  def header(text, level)
    '<h' + level.to_s + ' class="markdown_heading">' + "#{text}</h#{level}>" + '<style type="text/css">h' + level.to_s  + ' {border-bottom: inset 2px #ccc;}</style>'
  end

  def block_code(code, language)
    if language.present? && code.present?
      '<pre id="block_quote">' + '<strong>' + '<code id="file_name">' + language.to_s + '</code></strong>' + '<code id="code">' + code.to_s  + "</code></pre>" + '<style type="text/css">pre#block_quote {margin-top: 10px;margin-left: -20px;margin-right: -20px}code#code {padding-left: 30px;padding-right: 30px;padding-bottom: 10px}code#file_name{padding-top: 10px;padding-left: 30px;padding-right: 30px;padding-bottom: 20px;} </style>'
    elsif code.present?
      '<pre id="block_quote">' + '<code id="code">' +  code.to_s + '</code>' + '</pre>' + '<style type="text/css">pre#block_quote {margin-top: 10px;margin-left: -20px;margin-right: -20px;}code#code {padding-bottom: 10px;}</style>';
    end
  end

  def paragraph(text)
    return '<div id="paragraph">' + text.to_s + '</div><style type="text/css">div#paragraph {white-space:pre;}</style>'
  end

  def block_quote(quote)
    '<div id="block_quote">' + "#{quote}" + '</div>' + '<style type="text/css">div#block_quote div {margin-left: 10px;white-space:pre-line;}div#block_quote {color: #333;border-left: inset 9px #ccc;padding-top: 15px;padding-bottom: 15px;margin-top: 10px;padding-left: 10px;}</style>'
  end

  def list_item(text, list_type)
    '<li class="list">' + text.to_s + '</li><style type="text/css">li.list {margin-left: 20px;white-space:normal;}ul {white-space:normal;}</style>'
  end

  #redcarpetとmarked.jsでのリストの記法に少し異なりがあるので、統一するための修正
  def preprocess(full_document)
    renew_article = full_document.gsub("\n   - ", "\n     - ")
    return renew_article.gsub("\n    - ", "\n     - ")
  end


end
