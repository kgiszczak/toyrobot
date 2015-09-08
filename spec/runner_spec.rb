require 'runner'

RSpec.describe Runner do
  describe '#run' do
    it 'executes commands in order' do
      input = 'PLACE 0,0,NORTH MOVE RIGHT MOVE LEFT'
      runner = Runner.new(input)
      runner.run

      expect(runner.robot.x).to eq(1)
      expect(runner.robot.y).to eq(1)
      expect(runner.robot.direction).to eq('north')
    end
  end
end
