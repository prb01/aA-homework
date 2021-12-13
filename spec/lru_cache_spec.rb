require 'rspec'
require 'lru_cache'

describe LRUCache do
  let(:cache) { LRUCache.new(4) }

  describe '#initialize' do
    it 'sets a size' do
      expect(cache.size).to eq(4)
    end

    it 'creates an empty cache array' do
      expect(cache.cache).to be_a(Array)
      expect(cache.cache.empty?).to eq true
    end
  end

  describe '#count' do
    it 'outputs the amount of items in cache' do
      cache.add(11)
      cache.add(15)
      cache.add(17)
      expect(cache.count).to eq(3)
    end
  end

  describe '#add' do
    it 'allows to add integer' do
      cache.add(10)
      expect(cache.cache[0]).to be_a(Integer)
    end

    it 'allows to add string' do
      cache.add("striiing")
      expect(cache.cache[0]).to be_a(String)
    end

    it 'allows to add array' do
      cache.add([1, 2, 3])
      expect(cache.cache[0]).to be_a(Array)
    end

    it 'allows to add hashmap' do
      cache.add({a: 1, b: 2})
      expect(cache.cache[0]).to be_a(Hash)
    end

    it 'never goes above size' do
      7.times { |i| cache.add(i) }
      expect(cache.count).to eq(cache.size)
    end
  end

  describe '#show' do
    it 'prints items in cache with LRU first' do
      cache.add(1)
      cache.add(2)
      cache.add(3)
      cache.add(4)
      cache.add(1)
      cache.add("second")
      cache.add({third: 3})
      cache.add(4)
      expect(cache.show).to eq([1, "second", {:third=>3}, 4])
    end
  end
end