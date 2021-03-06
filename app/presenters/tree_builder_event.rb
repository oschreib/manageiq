class TreeBuilderEvent < TreeBuilder
  private

  def tree_init_options(_tree_name)
    {:full_ids => true}
  end

  def set_locals_for_render
    locals = super
    locals.merge!(
      :id_prefix => "ev_",
    )
  end

  # level 0 - root
  def root_options
    [t = N_("All Events"), t]
  end

  # level 1 - events
  def x_get_tree_roots(options)
    count_only_or_objects(options[:count_only], MiqPolicy.all_policy_events, :description)
  end

  # level 2 - nothing
  def x_get_tree_ev_kids(_parent, options)
    count_only_or_objects(options[:count_only], [])
  end
end
