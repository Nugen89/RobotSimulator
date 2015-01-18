require_relative '../command_processor'

describe "CommandProcessor" do

  let(:cmd) { CommandProcessor.new }

  it "default input type should be cmdline" do
    expect(cmd.type).to eq("cmdline")
  end

  it "cmd line input " do
    expect(cmd).to receive(:cmd_line_input)
    cmd.get_input
  end

end