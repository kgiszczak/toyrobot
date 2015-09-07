require 'command'

RSpec.describe Command do

  describe '#initialize' do
    context 'when invalid name' do
      it 'raises InvalidCommand error' do
        expect { Command.new('incorrect') }.to raise_error(Command::InvalidCommand)
      end
    end

    context 'when valid name' do
      it 'creates correct Command object' do
        command = Command.new('move', 'params')
        expect(command.name).to eq('move')
        expect(command.params).to eq('params')
      end
    end
  end

end
