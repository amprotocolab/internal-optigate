module Types
  class ArrayType < GraphQL::Schema::Scalar
    description 'Type to send or receive arrays'

    def self.coerce_input(value, _context)
      parsed = JSON.parse(value)

      if parsed.instance_of?(Array)
        parsed
      else
        raise GraphQL::CoercionError, "#{value.inspect} is not a valid Array"
      end
    rescue JSON::ParserError => e
      raise GraphQL::CoercionError, "#{value.inspect} is not a valid Array"
    end

    def self.coerce_result(value, _context)
      value
    end
  end
end
