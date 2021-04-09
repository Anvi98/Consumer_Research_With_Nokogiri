require 'nokogiri'
require 'httparty'

class Scraper
  attr_reader :url, :urls_cat, :parsed_html

  def initialize
    @url = 'https://www.trustpilot.com/review/www.revolut.com'
    @urls_cat = ['?aspects=experience', '?aspects=customer%20service', '?aspects=app']
    @raw_html = HTTParty.get(@url)
    @parsed_html = Nokogiri::HTML(@raw_html.body)
  end

  def total_review_num
    @total_reviews = @parsed_html.css('span.headline__review-count').text.gsub(',', '').to_i
  end

  def score
    @overall_score = @parsed_html.css('p.header_trustscore').text.to_f
  end

  def review_resume
    @last_review_wrapper = @parsed_html.css('div.review-content')[0]
    @last_review = {
      title: @last_review_wrapper.css('a').text.split.slice(0, 3).push('..').join(' '),
      content: @last_review_wrapper.css('p').text.split.join(' '),
      score: @last_review_wrapper.css('img').attr('alt').text.split(':')[0].split[0].to_i,
      date: @last_review_wrapper.css('div.review-content-header__dates').children[1].children.text.split('"')[3].split('T')[0]
    }
    @last_review
  end

  def resume_category
    @url_s = @url + @urls_cat[0]
    @raw_html = HTTParty.get(@url_s)
    @parsed_html = Nokogiri::HTML(@raw_html.body)
    @count_reviews = []
    @review_list = parsed_html.css('div.review-card img')
    @page = 1
    @excel = 0
    @bad = 0
    @good = 0

    while @page <= 20
      @review_list.each do
        @reviews = @review_list.select { |img| img.attr('alt').split(':')[0].split[0].to_i }
        @count_reviews = @reviews
      end
      @page += 1
    end

    @count_reviews.each { |review| @excel += 1 if review.attr('alt').split(':')[0].split[0].to_i == 5 }
    @count_reviews.each { |review| @good += 1 if review.attr('alt').split(':')[0].split[0].to_i == 4 }
    @count_reviews.each { |review| @bad += 1 if review.attr('alt').split(':')[0].split[0].to_i <= 3 }
    @render = [@excel, @good, @bad]
    p @render.length
    @render
  end
end
