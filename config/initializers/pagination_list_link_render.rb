#---
# 参照链接: http://thewebfellas.com/blog/2010/8/22/revisited-roll-your-own-pagination-links-with-will_paginate-and-rails-3
#
class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

    def page_number(page)
      unless page == current_page
        tag(:li, link(page, page, :rel => rel_value(page)))
      else
        tag(:li, tag(:a, page), :class => "active")
        #tag(:li, page, :class => "current")
      end
    end

    def previous_or_next_page(page, text, classname)
      if page
        tag(:li, link(text, page), :class => classname)
      else
        tag(:li, tag(:a, text), :class => classname + ' disabled')
      end
    end

    def html_container(html)
      #tag(:ul, html, container_attributes)
      tag(:div, tag(:ul, html), container_attributes)
    end

end

# 分页顶层div的class设置
WillPaginate::ViewHelpers.pagination_options[:class] = 'pagination pagination-centered'
