require 'json'
require 'fileutils'

module SaveGame
  SAVE_PATH = File.join(__dir__, '..', 'save_file', 'save.json')

  def self.save(secret, hide, rounds)
    dir = File.dirname(SAVE_PATH)
    FileUtils.mkdir_p(dir)

    data = {
      secret: secret,
      hide: hide,
      rounds: rounds
    }

    File.write(SAVE_PATH, JSON.generate(data))
  end

  def self.load
    return nil unless File.exist?(SAVE_PATH)

    JSON.parse(File.read(SAVE_PATH))
  end

  def self.delete
    File.delete(SAVE_PATH) if File.exist?(SAVE_PATH)
  end

  def self.exist?
    File.exist?(SAVE_PATH)
  end
end

