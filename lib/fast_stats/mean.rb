# frozen_string_literal: true

# A class for managing the arithmetic and geometric means
# of positive numbers
module FastStats
  class Mean

    DEFAULT_ROUND = 15
    attr_reader :sum, :log_sum, :n

    def initialize()
      @sum = 0.0
      @n = 0
      @log_sum = 0.0
      @log_n = 0
    end

    def add(val)
      throw ArgumentError.new "#add, val must be >= 0" if val < 0
      @sum += val
      @log_sum += safe_log(val)
      @n += 1
    end

    alias_method :<<, :add

    def arithmetic(round: DEFAULT_ROUND)
      return nil if n == 0
      (sum / n).round round
    end

    def geometric(round: DEFAULT_ROUND)
      return nil if n == 0
      (2 ** (log_sum / n)).round round
    end

    def summary(round: DEFAULT_ROUND)
      {
        "arithmetic" => arithmetic(round: round),
        "geometric" => geometric(round: round),
      }
    end

    private

    def safe_log(val)
      Math.log2 safe_geometric_mean_val(val)
    end

    def safe_geometric_mean_val(val)
      val > 0 ? val : 1
    end

  end
end
