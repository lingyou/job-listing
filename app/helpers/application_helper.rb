module ApplicationHelper
  def markdown(text)
    render_options = {no_links: false, hard_wrap: true, filter_html: true, safe_links_only:true}
    extensions = {
          no_intra_emphasis: true,
          fenced_code_blocks: true
          }
    renderer = Redcarpet::Render::HTML.new(render_options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    return markdown.render(text).html_safe
  end
end
