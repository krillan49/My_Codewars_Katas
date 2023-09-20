class SecretWord
  attr_reader :list, :word, :counter
  def initialize
    @list = 20.times.with_object([]) do |_, res|
      res << rand(4..7).times.with_object([]){|_, arr| arr << ('a'..'z').to_a[rand(26)]}.join
    end
    @word = @list.sample
    @counter = 0
  end

  def show_size
    @counter += 1
    @word.size
  end

  def show_letter(n)
    @counter += 1
    @word[n-1]
  end
end



def solution(sw)
  p list = sw.list
  p sw.word
  size = sw.show_size
  p list.select!{|word| word.size == size}
  letters = list.map(&:chars).transpose.map.with_index(1){|a, i| [i, a, a.tally]}#.sort_by{|n, a| }
  # letters.find{|k, v| v.}
end

p solution(SecretWord.new)
