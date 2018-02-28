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

    def summary(round: Mean::DEFAULT_ROUND)
      means.transform_values { |m| m.summary round: 2 }
    end

    private

    def mean_for(name)
      @means[name] ||= Mean.new
    end

  end
end
