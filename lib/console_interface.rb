require 'colorize'
require 'colorized_string'

class ConsoleInterface
  FIGURES =
    Dir[__dir__ + "/../data/figures/*.txt"].
      sort.
      map { |file| File.read(file) }

  def errors_to_show
    @game.errors.join(", ")
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def get_input
    print "Введите следующую букву: "
    letter = gets[0].upcase
    return letter
  end

  def initialize(game)
    @game = game
  end

  def print_out
    puts ColorizedString["Слово: #{word_to_show}"].colorize(:green)
    puts "#{figure.colorize(:yellow)}"
    puts ColorizedString["Ошибки (#{@game.errors_made}): #{errors_to_show}"].colorize(:red).blink
    puts "У вас осталось ошибок: #{@game.errors_allowed}"

    if @game.won?
      puts "Вы выиграли!".colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово #{@game.word}".colorize(:red).on_blue.underline
    end
  end

  def word_to_show
    result =
      @game.letters_to_guess.map { |letter| letter.nil? ? "__" : letter }

    result.join(" ")
  end
end
