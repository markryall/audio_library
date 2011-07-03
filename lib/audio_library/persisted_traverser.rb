require 'csv'
require 'ostruct'

module AudioLibrary; end

class AudioLibrary::PersistedTraverser
  include Enumerable

  def initialize path
    @path = path
  end

  def each
    CSV.foreach(@path) do |row|
      tuples = AudioLibrary::Executor::FIELDS.map {|field| [field, row.shift]}.flatten
      o = OpenStruct.new Hash[*tuples]
      o.extend AudioLibrary::Executor
      yield o
    end if File.exist? @path
  end

  def clear
    CSV.open @path, 'wb'
  end

  def append track
    CSV.open(@path, 'ab') do |csv|
      csv << track.to_a
    end
  end
end