require 'audio_library/id3_file'
require 'audio_library/ffmpeg_file'
require 'audio_library/exiftool_file'

module AudioLibrary
  module Parser
    def self.parse path
      parse_ffmpeg path
    end

    def self.parse_composite path
      track1 = parse_id3 path
      show_missing track1
      track2 = parse_ffmpeg path
      show_missing track2
      track3 = parse_exiftool path
      show_missing track3
      gets
      track1
    end

    def self.show_missing track
      missing = AudioLibrary::Executor::FIELDS.select {|field| !track.send field }
      unless missing.empty?
        puts track.to_a
        gets
      end
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