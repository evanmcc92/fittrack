module LikesHelper
	def like_link_for(target)
      link_to "", like_path(:resource_name => target  .class, :resource_id => target.id), :method => :post, class: "glyphicon glyphicon-star-empty"
    end

    def unlike_link_for(target)
      link_to "", like_path(:resource_name => target.class, :resource_id => target.id), :method => :delete, class: "glyphicon glyphicon-star"
    end
end
