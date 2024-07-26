require 'digest'

class Block
  attr_accessor :data, :previous_hash, :hash, :nonce, :index, :timestamp

  def initialize(data, previous_hash)
    @data = data
    @timestamp = Time.now
    @index = 0
    @previous_hash = previous_hash
    @hash = calculate_hash
    @nonce = 0
  end

  def calculate_hash
    Digest::SHA256.hexdigest(@index.to_s + @timestamp.to_s + @previous_hash + @data.to_s + @nonce.to_s)
  end

  def mine_block(difficulty)
    while @hash[0...difficulty] != "0" * difficulty
      @nonce += 1
      @hash = calculate_hash
    end
    puts "Block mined: #{@hash}"
  end
end