require 'config_reader'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ConfigReader do
  before(:each) do
    @config_reader = ConfigReader.new (File.dirname(__FILE__) + '/fixtures/config_empty.json')
  end

  it "should be 3 whitelist images" do
    expect(@config_reader.whitelist_images.size).to eq 3
    expect(@config_reader.whitelist_images.size).to eq 3
  end

  it "should contain chrislovsund/docker-cleaner:latest" do
    expect(@config_reader.whitelist_images.include?('chrislovsund/docker-cleaner:latest')).to eq true
  end
  it "should contain ruby:2.1-onbuild" do
    expect(@config_reader.whitelist_images.include?('ruby:2.1-onbuild')).to eq true
  end
end

