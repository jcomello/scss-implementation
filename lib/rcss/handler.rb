require_relative 'hash'

module RCSS
  class Handler
    attr_reader :stack

    def initialize
      @current_selector
      @stack = {}
    end

    def begin_rule
      # @stack << "{"
    end

    def end_rule
      # @stack << "}"
    end

    def selector(s)
      if @stack[@current_selector].nil?
        @current_selector = s
        @stack[@current_selector] = []
      else
        @stack[@current_selector].push({ s => [] })
        @current_selector = s
      end
    end

    def scalar(p)
      @stack = set_scalar(@stack, @current_selector, p)
    end

    def result
      @stack.unnest
    end

    def set_scalar(colection, key, value)
      result = colection
      if colection[key].nil?
        colection.each do |_,v|
          v.each do |el|
            set_scalar(el, key, value) unless el.is_a? String
          end
        end
      else
        result[key].push(value)
      end

      result
    end
  end
end
