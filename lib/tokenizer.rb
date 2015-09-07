require 'command'

class Tokenizer

  def self.tokenize(string)
    tokens = string.downcase.split(/\s+/)
    commands = []

    while tokens.length > 0
      token = tokens.shift

      if token == Command::PLACE
        params = tokens.shift.split(/,/)
        commands << Command.new(token, params)
      else
        commands << Command.new(token)
      end
    end

    commands
  end
end
