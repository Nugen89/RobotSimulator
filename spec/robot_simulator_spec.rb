require 'rspec'

require_relative '../command_processor'
require_relative '../robot_simulator'

describe RobotSimulator do

  let(:simulator) { RobotSimulator.new }

  it "will exit on input exit" do    
    expect(simulator.command_processor).to receive(:gets).and_return("exit")
    expect { simulator.start }.to raise_error SystemExit
  end

  it "place command" do
    expect(simulator.command_processor).to receive(:gets).and_return("place 1,2,NORTH")
    expect(simulator.command_processor).to receive(:gets).and_return("exit")
    expect(simulator.robot).to receive(:place).with("1,2,NORTH")
    expect { simulator.start }.to raise_error SystemExit
  end

  it "move command" do    
    expect(simulator.command_processor).to receive(:gets).and_return("move")
    expect(simulator.robot).to receive(:move).and_return NullCoordinatesException
    expect { simulator.start }.to raise_error NullCoordinatesException
  end

  it "left command" do    
    expect(simulator.command_processor).to receive(:gets).and_return("left")
    expect(simulator.robot).to receive(:left).and_return NullCoordinatesException
    expect { simulator.start }.to raise_error NullCoordinatesException
  end

  it "right command" do    
    expect(simulator.command_processor).to receive(:gets).and_return("right")
    expect(simulator.robot).to receive(:right).and_return NullCoordinatesException
    expect { simulator.start }.to raise_error NullCoordinatesException
  end

  it "report command" do    
    expect(simulator.command_processor).to receive(:gets).and_return("report")
    expect(simulator.robot).to receive(:report_location)
    expect(simulator.command_processor).to receive(:gets).and_return("exit")
    expect { simulator.start }.to raise_error SystemExit
  end

end