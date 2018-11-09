module MarkdownToc
  extend ActiveSupport::Concern

  included do

    def all_body
      self.body
      return "body is present"
    end

    def markdown_toc(cotent)
      id_count = 1
      toc_text = ''
      currentlevel = 0

      doc = Nokogiri::HTML.parse(content)
      doc.css('div.sc-content.c-container').css('h2, h3, h4').each do |h|
        h["id"] = 'chapter_' + id_count.to_s
        id_count += 1

        case h.name
        when 'h2' then
          level = 1
        when 'h3' then
            level = 2
        when 'h4' then
            level = 3
        else
            level = 0
        end


        while currentlevel < level do
            toc_text += '<ul class="chapter">'
            currentlevel += 1
        end

        while currentlevel > level do
            toc_text += '</ul>'
            currentlevel -= 1
        end

        toc_text += '<li><a href="#' + h['id'] + '">' + h.content + "</a></li>\n";
        end

        while currentlevel > 0 do
            toc_text += '</ul>'
            currentlevel -= 1
        end

        toc_text = '<div id=toc><span id=toctitle>目次</span>' + toc_text + '</div>'
        newcontent = doc.to_html

        newcontent.gsub(/{:toc}/, toc_text)
    end
  end
end
