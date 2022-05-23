require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @alphabet = ('a'..'z').to_a
    @letters = []
    10.times do
      @letters << @alphabet.sample
    end
  end

  def score
    @answer = params[:answer].downcase.split
    @points = 0
    if matching?(@answer, @letters)
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}")
      json = JSON.parse(response.read)
      json['found']
    else
      'Wrong word your score is 0!'
    end
  end

  def matching?(answer, letters)
    answer.each do |letter|
      if letters.include?(letter)
        letters.delete(letter)
      else
        false
      end
    end
    true
  end
end
