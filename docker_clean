#!/usr/bin/env ruby

path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH << path

require 'rubygems'
require 'bundler/setup'
Bundler.require :default
require 'docker'
require 'optparse'

options = {}
options[:url] = ENV["URL"]

OptionParser.new do |opts|
  opts.banner = "Usage: docker_clean [options]"

  opts.on("-uURL", "--url=URL", "Docker Host URL") do |r|
    options[:url] = r
  end
end.parse!

Docker.url = options[:url]

require 'docker_cleaner'

DockerCleaner.run 
