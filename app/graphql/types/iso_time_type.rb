module Types
  class IsoTimeType < GraphQL::Schema::Scalar
    description 'Time with zone in ISO 8601 format'

    def self.coerce_input(value, _context)
      Time.zone.parse(value)
    rescue ArgumentError
      raise GraphQL::CoercionError, "#{value.inspect} is not a valid Date"
    end

    def self.coerce_result(value, _context)
      value.iso8601
    end
  end
end
