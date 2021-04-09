require_relative '../lib/core'

describe Scraper do
  describe '#total_review_num' do
    it 'returns an integer which represents the total reviews of the App.' do
      temp = Scraper.new
      k = temp.total_review_num
      expect(k.is_a?(Integer)).to eql(true)
    end

    it 'returns an integer which represents the total reviews of the App.' do
      temp = Scraper.new
      k = temp.total_review_num
      expect(k.is_a?(String)).to eql(false)
    end
  end

  describe '#score' do
    it 'returns a float number representing the average score of appreciation of Revolut' do
      temp = Scraper.new
      k = temp.score
      expect(k.is_a?(Float)).to eql(true)
    end

    it 'returns false if number representing the average score of appreciation of Revolut is not integer' do
      temp = Scraper.new
      k = temp.score
      expect(k.is_a?(String)).to eql(false)
    end
  end

  describe '#review_resume' do
    it 'return a hash with title, content, score and date info' do
      temp = Scraper.new
      k = temp.review_resume
      expect(k.key?(:title) && k.key?(:content) && k.key?(:score) && k.key?(:date)).to eql(true)
    end
    it 'return 4 elements key-value pairs' do
      temp = Scraper.new
      k = temp.review_resume
      expect(k.length).to eql(4)
    end
  end

  describe '#resume_category' do
    it 'returns an array of three intergers that describe the quality of services of Revolut.' do
      temp = Scraper.new
      k = temp.resume_category
      expect(k.length).to eql(3)
    end

    it 'returns an array where the sum of each three intergers = 20' do
      temp = Scraper.new
      k = temp.resume_category
      sum = k.inject(:+)
      expect(sum).to eql(20)
    end
  end
end
