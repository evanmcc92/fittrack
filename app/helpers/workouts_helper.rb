module WorkoutsHelper


def add_wo_set_link(name)
  link_to_function name do |wo_set|
    wo_set.insert_html :bottom, :wo_sets, :partial => 'wo_set'
  end
end

end
