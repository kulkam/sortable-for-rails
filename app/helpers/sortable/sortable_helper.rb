# frozen_string_literal: true

module Sortable::SortableHelper
  def sortable(column, default: false, direction: :asc, scope: nil, **options, &block)
    current = column.to_s == params[:sort] || params[:sort].blank? && default
    current_direction = (params[:direction] || direction).to_s

    new_direction = direction.to_s
    if current
      new_direction = current_direction.to_s == "asc" ? "desc" : "asc"
    end

    link_to(url_for(sort: column, direction: new_direction), options) do
      label = block_given? ? capture(&block) : column
      sortable_label_for(label, current, current_direction, scope)
    end
  end

  def sortable_label_for(label, active, direction, scope)
    render "sortable/label", label: label, active: active, direction: direction, scope: scope
  end
end
