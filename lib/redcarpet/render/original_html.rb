class Redcarpet::Render::OriginalHTML < Redcarpet::Render::HTML
  def header(text, level)
    "<h#{level}>#{text}</h#{level}>" + '<style type="text/css">h' + level.to_s  + ' {border-bottom: inset 2px #ccc;}</style>'
  end

  def block_code(code, language)
    "<pre>" + '<strong><code id="file_name">' + language.to_s + '</code></strong>' + '<code id="code">' + code.to_s  + "</code></pre>" + '<style type="text/css">pre {margin-top: 10px;margin-left: -1.5%;margin-right: -1.5%;}code#code {padding-left: 30px;padding-right: 30px;}code#file_name{padding-left: 30px;padding-right: 30px;} </style>'
  end
end
