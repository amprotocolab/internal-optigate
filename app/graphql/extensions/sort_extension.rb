module Extensions
  class SortExtension < GraphQL::Schema::FieldExtension
    def apply
      sort_columns_type   = options.fetch(:sort_column_type, Types::BaseSortColumnsEnumType)
      sort_order_default  = options.fetch(:sort_order_default, :asc)
      sort_column_default = options.fetch(:sort_column_default, :created_at)

      field.argument(:sort_column, sort_columns_type, required: false, default_value: sort_column_default)
      field.argument(:sort_order, Types::SortOrderEnumType, required: false, default_value: sort_order_default)
    end

    def resolve(object:, arguments:, **rest)
      sort_column      = arguments.delete(:sort_column)
      sort_order       = arguments.delete(:sort_order)
      custom_sort      = options.dig(:relationship_custom_sort, sort_column)
      secondary_column = options.dig(:secondary_column, sort_column)

      ar_relation = yield(object, arguments)
      return ar_relation unless ar_relation.respond_to?(:order) && [sort_column, sort_order].all?

      ordered_query =
        if custom_sort.present? && ([:join_table, :order_column] - custom_sort.keys).empty?
          ar_relation
            .joins(custom_sort[:join_table])
            .order(custom_sort[:order_column] + ' ' + sort_order.to_s.upcase)
        else
          ar_relation.order(sort_column => sort_order)
        end

      if secondary_column.present?
        ordered_query.order(secondary_column => sort_order)
      else
        ordered_query
      end
    end
  end
end
