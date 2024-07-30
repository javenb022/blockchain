require "digest"
require "pp"
require "pry"

class Block
  attr_reader :data, :hash
  attr_accessor :prev_hash, :nonce # Creates setter method to re-assign this value in the method in Blockchain

  def initialize(data, prev_hash = "")
    @data = data
    @prev_hash = prev_hash
    @hash = calculate_hash
    @nonce = 0
  end

  def calculate_hash
    Digest::SHA256.hexdigest("#{nonce}#{prev_hash}#{data}")
  end

  def mine_block(num_zeros)
    pattern = '0' * num_zeros
    while @hash[0, num_zeros] != pattern
      @nonce += 1
      @hash = calculate_hash
    end
    puts "Block mined: #{@hash}"
  end
end