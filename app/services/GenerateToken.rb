class GenerateToken
  def self.generate
    SecureRandom.hex
  end
end
