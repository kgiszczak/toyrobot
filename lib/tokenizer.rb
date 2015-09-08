require 'command'

# Tokenizes input string and returns array of valid commands
class Tokenizer

  # Returns array of valid commands
  #
  # @param string [String] A string containing commands to execute
  #
  # @return [Array] a list of valid commands to execute
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
