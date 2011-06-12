require 'audio_library/executor'
require 'id3lib'
require 'rchardet19'
require 'pp'

class AudioLibrary::Id3File
  include AudioLibrary::Executor

  def initialize path
    extract_file_attributes path
    tags = ID3Lib::Tag.new @path
    @title = reencode tags.title
    @album = reencode tags.album
    @artist = reencode (tags.band || tags.performer)
    @time = tags.time.to_i if tags.time
    @date = (tags.date || tags.year)
    @track = tags.track
  end

  def reencode value
    retur nil unless value
    cd = CharDet.detect value
    value.force_encoding cd[:encoding]
    value.encode 'UTF-8'
  end
end