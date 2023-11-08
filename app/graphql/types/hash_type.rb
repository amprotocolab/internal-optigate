module Types
  class HashType < GraphQL::Schema::Scalar
    description 'Type to send or receive hashes'

    def self.coerce_input(value, _context)
      parsed = JSON.parse(value.to_json)

      if parsed.instance_of?(Hash)
        parsed
      else
        raise GraphQL::CoercionError, "#{value.inspect} is not a valid Hash"
      end
    rescue JSON::ParserError => e
      raise GraphQL::CoercionError, "#{value.inspect} is not a valid Hash"
    end

    def self.coerce_result(value, _context)
      value
    end
  end
end
