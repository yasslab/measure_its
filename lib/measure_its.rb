require "measure_its/version"

module MeasureIts
  class << self
    def add_strategy(name, &block)
      strategies[name] = block
    end

    def build(names)
      original = nil
      ss = names.map { |n| strategies.fetch(n) }
      new_method = ss.reverse_each.inject(lambda { original.call }) do |acc, s|
        lambda { s.call(&acc) }
      end
      lambda do |o|
        original = o
        new_method.call
      end
    end

    private

    def strategies
      @strategies ||= {}
    end
  end

  def measure_its(m, with:)
    m = Module.new do
      with_measure = MeasureIts.build(with)
      define_method(m) do |*args, &blk|
        with_measure.call(lambda { super(*args, &blk) })
      end
    end
    self.prepend(m)
  end

  refine(Module) do
    include MeasureIts
  end
end
