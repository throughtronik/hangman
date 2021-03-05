class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @user_guesses = []
  end

  def errors
    @user_guesses - normalized_letters
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def errors_made
    errors.size
  end

  def letters_to_guess
    @letters.map { |letter| letter if @user_guesses.include?(normalize_letter(letter)) }
  end

  def lost?
    errors_allowed.zero?
  end

  def normalize_letter(letter)
    case letter
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else letter
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) }
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    normalized_letter = normalize_letter(letter)
    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def word
    @letters.join
  end

  def won?
    (normalized_letters - @user_guesses).empty?
  end
end
