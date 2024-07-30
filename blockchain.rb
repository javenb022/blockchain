require "pp"
require "./block.rb"
require "pry"

class Blockchain
  attr_accessor :chain

  def initialize
    @chain = [create_genesis_block]
    @difficulty = 1
  end

  def create_genesis_block
    Block.new("Genesis Block", "0000000000000000000000000000000000000000000000000000000000000000")
  end

  def add_new_block_to_blockchain(new_block)
    grab_prev_hash(new_block)
    new_block.mine_block(@difficulty)
    chain << new_block
  end

  def grab_prev_hash(new_block)
    # When instantiating a block, it grabs the hash of the block that was instantiated before it
    # before being added to the chain

    new_block.prev_hash = chain.last.hash
  end

  def valid_chain?
    @chain.each_with_index do |block, index|
      next if index == 0
      previous_block = @chain[index - 1]
      return false if block.hash != block.calculate_hash
      return false if block.prev_hash != previous_block.hash
    end
    true
  end
end

blockchain = Blockchain.new
b0 = Block.new("First block")
b1 = Block.new("Second Block")
b2 = Block.new("Third Block")

blockchain.add_new_block_to_blockchain(b0)
blockchain.add_new_block_to_blockchain(b1)
blockchain.add_new_block_to_blockchain(b2)

puts blockchain.chain
puts blockchain.valid_chain?