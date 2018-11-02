module MarkdownHelper
  def markdown(text)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis  => true,
      :autolink           => true,
      :strikethrough      => true,
      :lax_html_blocks    => true,
      :superscript        => true,
      :highlight => true
    }

    extensions = {
      :fenced_code_blocks => true,
      autolink:           true,
      no_intra_emphasis:  true,
      tables:             true
    }

    # renderer = Redcarpet::Render::HTML.new(options)
    renderer = Redcarpet::Render::OriginalHTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end

end
