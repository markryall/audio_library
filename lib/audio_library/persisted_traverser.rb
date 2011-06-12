require 'csv'
require 'ostruct'

module AudioLibrary; end

class AudioLibrary::PersistedTraverser
  include Enumerable

  FIELDS = %w{path timestamp album track title artist time date}

  def initialize path
    @path = path
  end

  def each
    CSV.foreach(@path) do |row|
      tuples = FIELDS.map {|field| [field, row.shift]}.flatten
      yield OpenStruct.new Hash[*tuples]
    end if File.exist? @path
  end

  def clear
    CSV.open @path, 'wb'
  end

  def append track
    CSV.open(@path, 'ab') do |csv|
      csv << FIELDS.map { |field| track.send field }
    end
  end
end