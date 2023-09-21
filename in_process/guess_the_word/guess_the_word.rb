class SecretWord
  attr_reader :list, :word, :counter
  def initialize
    size = rand(4..7)
    @list = 20.times.with_object([]) do |_, res|
      res << size.times.with_object([]){|_, arr| arr << ('a'..'z').to_a[rand(26)]}.join
    end
    @word = @list.sample
    @counter = 0
  end

  def show_letter(n)
    @counter += 1
    @word[n-1]
  end
end



def solution(sw)
  p list = sw.list
  p sw.word
  letters = list.map(&:chars).transpose.map{|a| a.map{|e| [e, a.count(e)]}}.transpose.sort_by{|w| [*w.map(&:last).sort]}
  # letters.find{|k, v| v.}
end

p solution(SecretWord.new)
