# frozen_string_literal: true

# A class for managing the arithmetic and geometric means
# of positive numbers
module FastStats
  class Means

    attr_reader :means

    def initialize
      @means = {}
    end

    def add(name, val)
      mean_for(name) << val
    end

    def summary
      means.values.reduce({}) do |summary, mean|
        summary.merge mean.summary
      end
    end

    private

    def mean_for(name)
      @means[name] ||= Mean.new name: name
    end

  end
end
