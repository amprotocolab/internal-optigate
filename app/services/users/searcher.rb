module Users
  class Searcher
    def self.call(attrs)
      new(attrs).call
    end

    def initialize(attrs)
      @name = attrs[:query]
    end

    def call
      query = User.all
      query = query.by_full_name(name) if name.present?

      query
    end

    attr_reader :name
  end
end
