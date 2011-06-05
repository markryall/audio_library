require 'pathname'

class AudioLibrary::Traverser
  attr_reader :current

  def initialize path
    @path = Pathname.new path
    @traverser = Fiber.new do
      @path.find { |child| Fiber.yield child if child.file? }
      Fiber.yield nil
    end
    @current = :first
  end

  def base
    @path
  end

  def next
    @current = @traverser.resume if @current
  end

  def relative
    @current.relative_path_from(@path).to_s if @current
  end

  def timestamp
    @current.mtime.to_i if @current
  end

  def to_s
    "#{relative}:#{timestamp}"
  end

  def empty?
    @current.nil?
  end
end