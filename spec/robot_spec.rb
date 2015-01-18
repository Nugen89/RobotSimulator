require_relative '../robot'

describe Robot do

  let(:robot) { Robot.new }

  it "should split and capitalise input string" do
    expect(robot.coordinates.class).to eq(NullCoordinates)
    expect(robot.direction).to eq(nil)
  end

  describe 'valid placement' do
    it "should place robot on the board" do
      robot.place("0,0,NORTH")
      expect(robot.coordinates).to eq([0,0])
      expect(robot.direction).to eq("NORTH")
    end

    it "should place robot on the board" do
      robot.place("4,4,SOUTH")
      expect(robot.coordinates).to eq([4,4])
      expect(robot.direction).to eq("SOUTH")
    end

    it "should place robot on the board" do
      robot.place("0,0,NORTH")
      expect(robot.coordinates).to eq([0,0])
      expect(robot.direction).to eq("NORTH")
      robot.place("3,4,EAST")
      expect(robot.coordinates).to eq([3,4])
      expect(robot.direction).to eq("EAST")
    end   
  end

  describe 'invalid placement' do
    it "should reject invalid coordinates" do
      expect(robot.place("5,1,NORTH")).to eq("Invalid robot placement")
      expect(robot.coordinates.class).to eq(NullCoordinates)
      expect(robot.direction).to eq(nil)
    end

    it "should reject invalid coordinates" do
      expect(robot.place("-1,1,NORTH")).to eq("Invalid robot placement")
      expect(robot.coordinates.class).to eq(NullCoordinates)
      expect(robot.direction).to eq(nil)
    end

    it "should reject invalid direction" do
      expect(robot.place("3,1,NORTHEAST")).to eq("Invalid robot placement")
      expect(robot.coordinates.class).to eq(NullCoordinates)
      expect(robot.direction).to eq(nil)
    end

    it "should not allow movement without placement" do
      expect{robot.move}.to raise_error(NullCoordinatesException)
    end

    it "should not allow rotation without placement" do
      expect{robot.left}.to raise_error(NullCoordinatesException)
    end

    it "should not allow rotation without placement" do
      expect{robot.right}.to raise_error(NullCoordinatesException)
    end

   it "should not report without placement" do
      expect{robot.report_location}.to raise_error(NullCoordinatesException)
    end
  end

  describe "valid moves" do
    before do
      robot.coordinates = [2,2]
      robot.direction = "NORTH"
    end

    it "moving north" do
      robot.move
      expect(robot.coordinates).to eq([2,3])
      expect(robot.direction).to eq("NORTH")
    end

    it "moving north" do
      robot.move.move
      expect(robot.coordinates).to eq([2,4])
      expect(robot.direction).to eq("NORTH")
    end

    it "moving south" do
      robot.direction = "SOUTH"
      robot.move
      expect(robot.coordinates).to eq([2,1])
      expect(robot.direction).to eq("SOUTH")
    end

    it "moving east" do
      robot.direction = "EAST"
      robot.move
      expect(robot.coordinates).to eq([3,2])
      expect(robot.direction).to eq("EAST")
    end

    it "moving west" do
      robot.direction = "WEST"
      robot.move
      expect(robot.coordinates).to eq([1,2])
      expect(robot.direction).to eq("WEST")
    end
  end

  describe "invalid moves" do
    context "placed at [4,4]" do
      before do
        robot.coordinates = [4,4]
      end

      it "should not move north" do
        robot.direction = "NORTH"
        robot.move
        expect(robot.coordinates).to eq([4,4])
        expect(robot.direction).to eq("NORTH")
      end

      it "should not move east" do
        robot.direction = "EAST"
        robot.move
        expect(robot.coordinates).to eq([4,4])
        expect(robot.direction).to eq("EAST")
      end     
    end

    context "placed at [0,0]" do
      before do
        robot.coordinates = [0,0]
      end

      it "should not move south" do
        robot.direction = "SOUTH"
        robot.move
        expect(robot.coordinates).to eq([0,0])
        expect(robot.direction).to eq("SOUTH")
      end

      it "should not move west" do
        robot.direction = "WEST"
        robot.move
        expect(robot.coordinates).to eq([0,0])
        expect(robot.direction).to eq("WEST")
      end     
    end
  end

  describe "rotations" do
    before do
      robot.coordinates = [2,2]
      robot.direction = "NORTH"
    end

    it "should rotate left" do
      robot.left
      expect(robot.direction).to eq("WEST")
    end

    it "should rotate right" do
      robot.right
      expect(robot.direction).to eq("EAST")
    end

    it "should rotate multiple times" do
      robot.right.right
      expect(robot.direction).to eq("SOUTH")
    end

    it "should rotate multiple times" do
      robot.left.left
      expect(robot.direction).to eq("SOUTH")
    end
  end

  describe "report location" do
    before do
      robot.coordinates = [2,2]
      robot.direction = "NORTH"
    end

    it "should return current location" do
      expect(robot.report_location).to eq("2,2 | NORTH")
    end
  end

  describe "full test" do
    it "test all components" do
      robot.place("1,2,EAST")
      robot.move.move.left.move
      expect(robot.report_location).to eq("3,3 | NORTH")
    end
  end

end