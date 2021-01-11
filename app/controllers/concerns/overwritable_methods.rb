module OverwritableMethods
  extend ActiveSupport::Concern

  #####################################################
  ## Controller helper methods to be overwritten
  #####################################################

  def default_filters_enabled
    true
  end

  def default_search_enabled
    true
  end

  def enable_id_order
    true
  end

  def translated_column
    sort_column&.underscore
  end

  def apply_filters(obj)
    obj
  end
end
