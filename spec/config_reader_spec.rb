require 'config_reader'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe ConfigReader do
  before(:each) do
    @config_reader = ConfigReader.new (File.dirname(__FILE__) + '/fixtures/config.json')
  end

  it "should be 6 whitelist images" do
    expect(@config_reader.whitelist_images.size).to eq 6
    expect(@config_reader.whitelist_images.size).to eq 6
  end

  it "should contain image1" do
    expect(@config_reader.whitelist_images.include?('image1')).to eq true
  end
  it "should contain image2" do
    expect(@config_reader.whitelist_images.include?('image2')).to eq true
  end
  it "should contain image3" do
    expect(@config_reader.whitelist_images.include?('image3')).to eq true
  end
  it "should contain chrislovsund/docker-cleaner:latest" do
    expect(@config_reader.whitelist_images.include?('chrislovsund/docker-cleaner:latest')).to eq true
  end
  it "should contain ruby:2.1-onbuild" do
    expect(@config_reader.whitelist_images.include?('ruby:2.1-onbuild')).to eq true
  end
end

