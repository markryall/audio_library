require 'rubygems'
require 'id3lib'
require 'rchardet19'
require 'pp'

class AudioLibrary::Id3File
  attr_reader :path, :timestamp

  def initialize path
    @path = path.to_s
    @timestamp = path.timestamp
    @tags = ID3Lib::Tag.new @path
  end

  def method_missing method
    value = @tags.send method
    return nil unless value
    cd = CharDet.detect value
    value.force_encoding cd[:encoding]
    value.encode 'UTF-8'
  end

  def dump
    @tags.each do |f|
      pp f
    end
  end
end