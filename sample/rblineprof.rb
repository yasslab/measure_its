require 'measure_its'
require 'rblineprof'

using MeasureIts

MeasureIts.add_strategy(:rblineprof) do |&block|
  puts :begin
  prof = lineprof(/./) { block.call }
  p prof
  puts :end
end

class C
  def hi(greeting)
    puts greeting + yield
  end
  measure_its :hi, with: [:rblineprof]
end

C.new.hi('こんにちは！') { '世界' }
