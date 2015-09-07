require 'robot'

RSpec.describe Robot do

  describe '#initialize' do
    context 'when incorrect direction' do
      it 'raises IncorrectDirection error' do
        expect { Robot.new(0, 0, 'incorrect') }.to raise_error(Robot::IncorrectDirection)
      end
    end

    context 'when incorrect x position' do
      it 'raises IncorrectPosition error' do
        expect { Robot.new(-1, 0, 'north') }.to raise_error(Robot::IncorrectPosition)
      end
    end

    context 'when incorrect y position' do
      it 'raises IncorrectPosition error' do
        expect { Robot.new(0, -1, 'north') }.to raise_error(Robot::IncorrectPosition)
      end
    end

    context 'when correct parameters' do
      it 'creates robot object' do
        robot = Robot.new(0, 0, 'north')
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
        expect(robot.direction).to eq('north')
      end
    end
  end

  describe '#left' do
    {
      'north' => 'west',
      'west' => 'south',
      'south' => 'east',
      'east' => 'north'
    }.each do |from, to|
      it "changes direction from #{from} to #{to}" do
        robot = Robot.new(0, 0, from)
        robot.left
        expect(robot.direction).to eq(to)
      end
    end
  end

  describe '#right' do
    {
      'north' => 'east',
      'east' => 'south',
      'south' => 'west',
      'west' => 'north'
    }.each do |from, to|
      it "changes direction from #{from} to #{to}" do
        robot = Robot.new(0, 0, from)
        robot.right
        expect(robot.direction).to eq(to)
      end
    end
  end

  describe '#move' do
    context 'when direction is "north"' do
      context "when x position is lower then or equal to #{Robot::POSITION_X_MAX}" do
        subject { Robot.new(0, 0, 'north') }

        it 'increments x position' do
          subject.move
          expect(subject.x).to eq(1)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end
      end

      context "when x position is equal #{Robot::POSITION_X_MAX}" do
        subject { Robot.new(Robot::POSITION_X_MAX, 0, 'north') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(Robot::POSITION_X_MAX)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end
      end
    end

    context 'when direction is "east"' do
      context "when y position is lower then #{Robot::POSITION_Y_MAX}" do
        subject { Robot.new(0, 0, 'east') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end

        it 'increments y position' do
          subject.move
          expect(subject.y).to eq(1)
        end
      end

      context "when y position is equal #{Robot::POSITION_Y_MAX}" do
        subject { Robot.new(0, Robot::POSITION_Y_MAX, 'east') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(Robot::POSITION_Y_MAX)
        end
      end
    end

    context 'when direction is "south"' do
      context "when x position is greater then 0" do
        subject { Robot.new(2, 0, 'south') }

        it 'decrements x position' do
          subject.move
          expect(subject.x).to eq(1)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end
      end

      context "when x position is equal 0" do
        subject { Robot.new(0, 0, 'south') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end
      end
    end

    context 'when y direction is "west"' do
      context "when y position is greater then 0" do
        subject { Robot.new(0, 2, 'west') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end

        it 'decrements y position' do
          subject.move
          expect(subject.y).to eq(1)
        end
      end

      context "when y position is equal 0" do
        subject { Robot.new(0, 0, 'west') }

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end
      end
    end
  end

  describe '#report' do
    it 'returns string with robot position and direction' do
      robot = Robot.new(2, 3, 'west')
      expect(robot.report).to eq('2, 3, west')
    end
  end

end
