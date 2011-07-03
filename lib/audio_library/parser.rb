require 'audio_library/id3_file'
require 'audio_library/ffmpeg_file'
require 'audio_library/exiftool_file'

module AudioLibrary
  module Parser
    def self.parse path
      track = parse_ffmpeg path
      debug track.to_a.inspect
      track = parse_exiftool path if track.no_tag_fields?
      debug track.to_a.inspect
      track = parse_id3 path if track.no_tag_fields?
      debug track.to_a.inspect
      track
    end

    def self.debug message
      puts message if ENV['DEBUG']
    end

    def self.parse_id3 path
      debug "Parsing #{path} with Id3"
      AudioLibrary::Id3File.new path
    end

    def self.parse_ffmpeg path
      debug "Parsing #{path} with Ffmpeg"
      AudioLibrary::FfmpegFile.new path
    end

    def self.parse_exiftool path
      debug "Parsing #{path} with Exiftool"
      AudioLibrary::ExiftoolFile.new path
    end
  end
end