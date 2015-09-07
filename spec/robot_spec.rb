require 'robot'

RSpec.describe Robot do

  describe '#place' do
    subject { Robot.new(0, 0, 'north') }

    context 'when incorrect direction' do
      it 'raises IncorrectDirection error' do
        expect { subject.place(0, 0, 'incorrect') }.to raise_error(Robot::IncorrectDirection)
      end
    end

    context 'when incorrect x position' do
      it 'raises IncorrectPosition error' do
        expect { subject.place(-1, 0, 'north') }.to raise_error(Robot::IncorrectPosition)
      end
    end

    context 'when incorrect y position' do
      it 'raises IncorrectPosition error' do
        expect { subject.place(0, -1, 'north') }.to raise_error(Robot::IncorrectPosition)
      end
    end

    context 'when correct parameters' do
      it 'changes robot position and direction' do
        subject.place(1, 1, 'west')
        expect(subject.x).to eq(1)
        expect(subject.y).to eq(1)
        expect(subject.direction).to eq('west')
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
      context "when y position is lower then or equal to #{Robot::POSITION_Y_MAX}" do
        subject { Robot.new(0, 0, 'north') }

        it 'increments y position' do
          subject.move
          expect(subject.y).to eq(1)
        end

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end
      end

      context "when y position is equal #{Robot::POSITION_Y_MAX}" do
        subject { Robot.new(0, Robot::POSITION_Y_MAX, 'north') }

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(Robot::POSITION_Y_MAX)
        end

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end
      end
    end

    context 'when direction is "east"' do
      context "when x position is lower then #{Robot::POSITION_X_MAX}" do
        subject { Robot.new(0, 0, 'east') }

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end

        it 'increments x position' do
          subject.move
          expect(subject.x).to eq(1)
        end
      end

      context "when x position is equal #{Robot::POSITION_X_MAX}" do
        subject { Robot.new(Robot::POSITION_X_MAX, 0, 'east') }

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(Robot::POSITION_X_MAX)
        end
      end
    end

    context 'when direction is "south"' do
      context "when y position is greater then 0" do
        subject { Robot.new(0, 2, 'south') }

        it 'decrements y position' do
          subject.move
          expect(subject.y).to eq(1)
        end

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end
      end

      context "when y position is equal 0" do
        subject { Robot.new(0, 0, 'south') }

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end

        it 'does not change x position' do
          subject.move
          expect(subject.x).to eq(0)
        end
      end
    end

    context 'when direction is "west"' do
      context "when x position is greater then 0" do
        subject { Robot.new(2, 0, 'west') }

        it 'does not change y position' do
          subject.move
          expect(subject.y).to eq(0)
        end

        it 'decrements x position' do
          subject.move
          expect(subject.x).to eq(1)
        end
      end

      context "when x position is equal 0" do
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
