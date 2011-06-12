require 'audio_library/id3_file'
require 'audio_library/ffmpeg_file'
require 'audio_library/exiftool_file'

module AudioLibrary
  module Parser
    FIELDS = %w{path timestamp album track title artist time date}

    def self.parse path
      parse_composite path
    end

    def self.parse_composite path
      track = parse_id3 path
      missing = FIELDS.select {|field| !track.send field }
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
  end
end