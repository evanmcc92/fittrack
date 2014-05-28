module ApplicationHelper
	
  include Twitter::Autolink

	def devise_mapping
	  Devise.mappings[:user]
	end

	def resource_name
	  devise_mapping.name
	end

	def resource_class
	  devise_mapping.to
	end
	
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sortcolumn ? "current #{sortdirection}" : nil
		direction = column == sortcolumn && sortdirection == "asc" ? "desc" : "asc"
		link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end

	def userall
		User.all
	end
end