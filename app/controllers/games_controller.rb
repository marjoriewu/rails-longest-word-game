require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }.join
  end

  def score
    if (params[:letters].downcase.each_char.sort.include? params[:input].each_char.sort) == false && params[:input].each_char.size <= params[:letters].each_char.size
      @message = "Sorry but #{params[:input]} can't be built out of #{params[:letters]}"
    elsif english_word?(params[:input])
      @message = "Congratulations! #{params[:input]} is a valid English word."
    else
      @message = "Sorry but #{params[:input]} does not seem to be a valid English word."
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
