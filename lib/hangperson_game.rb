class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :word
  attr_accessor :word_with_guesses
  attr_reader   :check_win_or_lose
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = "-" * word.size.to_i
    @check_win_or_lose = :play
  end
  
  def guess(letter)
    raise ArgumentError unless letter =~ /^[a-z]$/i
    if @guesses.capitalize.include? letter.capitalize or @wrong_guesses.capitalize.include? letter.capitalize
      return false
    else
      if @word.include? letter
        @guesses << letter
        @word_with_guesses = @word.gsub(Regexp.new(eval('/[^'+@guesses+']/')),'-')
        @check_win_or_lose = :win unless @word_with_guesses.include? '-'
      else
        @wrong_guesses << letter
        @check_win_or_lose = :lose unless @wrong_guesses.size < 7
      end
    end
    true
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
