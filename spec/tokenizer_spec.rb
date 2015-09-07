require 'tokenizer'

RSpec.describe Tokenizer do

  describe '.tokenize' do
    context 'when input string contains invalid command' do
      it 'raises InvalidCommand error' do
        string = 'MOVE LEFT RIGHT INVALID PLACE'
        expect { Tokenizer.tokenize(string) }.to raise_error(Command::InvalidCommand)
      end
    end

    context 'when input string contains valid command' do
      it 'return array of commands' do
        string = 'PLACE 0,0,NORTH MOVE LEFT RIGHT REPORT'
        commands = Tokenizer.tokenize(string)

        expect(commands[0].name).to eq(Command::PLACE)
        expect(commands[0].params).to eq(['0', '0', 'north'])
        expect(commands[1].name).to eq(Command::MOVE)
        expect(commands[2].name).to eq(Command::LEFT)
        expect(commands[3].name).to eq(Command::RIGHT)
        expect(commands[4].name).to eq(Command::REPORT)
      end
    end
  end

end
