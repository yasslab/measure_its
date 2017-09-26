require "measure_its/version"

module MeasureIts
  class << self
    def add_strategy(name, &block)
      strategies[name] = block
    end

    def build(names)
      ss = names.map { |n| strategies.fetch(n) }
      ss.reverse_each.inject(lambda { yield }) do |acc, s|
        lambda { s.call(&acc) }
      end
    end

    private

    def strategies
      @strategies ||= {}
    end
  end

  def measure_its(m, with:)
    original = instance_method(m)
    m = Module.new do
      define_method(m) do |*args, &blk|
        MeasureIts.build(with) {
          super(*args, &blk)
        }.call
      end
    end
    self.prepend(m)
  end

  refine(Module) do
    include MeasureIts
  end
end
