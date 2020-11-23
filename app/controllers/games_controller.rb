require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.shuffle[0,10].join
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    raw_result = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    result = JSON.parse(raw_result)
    #@word.split("").all? {|c| @letters.include?(c.upcase)} == false

    if @word.split("").all? {|c| @letters.include?(c.downcase)} == false
      @answer = "Sorry, but #{@word} can't be build out of #{@letters}"
    elsif result["found"] == false
      @answer = "Sorry, but #{@word} doesn't seem to be a valid English word"
    else result["found"] == true
      @answer = "Congratulations! #{@words} is a valid English word!"
    end
  end
end
