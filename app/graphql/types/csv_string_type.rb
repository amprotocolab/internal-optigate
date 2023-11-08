require 'csv'

module Types
  class CSVStringType < GraphQL::Schema::Scalar
    description 'CSV string with headers in the first row'

    def self.coerce_input(value, _context)
      CSV.parse(value, headers: true)
    rescue CSV::MalformedCSVError
      raise GraphQL::CoercionError, 'csv is not valid'
    end

    def self.coerce_result(value, _context)
      value.to_s
    end
  end
end
