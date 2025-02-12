module UsersHelper
  def dashboard_link(name, path, active_tab, icon_svg)
    active = params[:tab] == active_tab ? "bg-green-50 text-green-700" : "text-gray-600 hover:bg-gray-50"
    content_tag :div, class: "w-full flex items-center space-x-3 px-4 py-4 text-sm rounded-lg transition-colors #{active}" do
      concat(raw(icon_svg))
      concat(content_tag(:span, name, class: "font-bold"))
      concat(tag.svg(class: "w-4 h-4 ml-auto", xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", stroke: "currentColor", stroke_width: 2) do
        tag.path(d: "M9 18l6-6-6-6")
      end)
    end
  end

  def dashboard_icon(active_tab, icon_svg)
    active = params[:tab] == active_tab ? "text-green-700 fill-green-700" : "text-gray-600 hover:text-gray-900"
    content_tag :div, class: "transition-colors #{active}" do
      raw(icon_svg)
    end
  end
end
