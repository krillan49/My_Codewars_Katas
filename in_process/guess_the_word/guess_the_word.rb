class SecretWord
  attr_reader :word, :list
  def initialize
    @list = 20.times.with_object([]) do |_, res|
      res << rand(4..7).times.with_object([]){|_, arr| arr << ('a'..'z').to_a[rand(26)]}.join
    end
    @word = @list.sample
  end
end

sw = SecretWord.new
p sw.list
p sw.word
