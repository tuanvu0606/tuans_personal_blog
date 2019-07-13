module ApplicationHelper

  def cart_count_over_one
  	#binding.pry
    if @order != nil
      if @order.order_line_items.count > 0
        #binding.pry
        return "<span class='tag is-dark'>#{@order.order_line_items.sum(:order_item_qty)}</span>".html_safe
        #render html: @cart.order_line_items.count
      end
    end
  end

  def cart_has_items
    return @order.order_line_items.count > 0
  end	
  
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:line_numbers => :table)
    end
  end
  
  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, 
                                  :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :lax_html_blocks => true,
      :fenced_code_blocks => true,
      :gh_blockcode => true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end
end
