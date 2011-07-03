require 'audio_library/id3_file'
require 'audio_library/ffmpeg_file'
require 'audio_library/exiftool_file'

module AudioLibrary
  module Parser
    def self.parse path
      debug "Parsing #{path.to_s}"
      track = parse_ffmpeg path
      track = parse_exiftool path if track.no_tag_fields?
      track = parse_id3 path if track.no_tag_fields?
      track
    end

    def self.parse_id3 path
      AudioLibrary::Id3File.new path
    end

    def self.parse_ffmpeg path
      AudioLibrary::FfmpegFile.new path
    end

    def self.parse_exiftool path
      AudioLibrary::ExiftoolFile.new path
    end

    def self.debug message
      puts message if ENV['DEBUG']
    end
  end
end