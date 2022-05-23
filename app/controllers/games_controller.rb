require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @all_letters = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @letters = @all_letters.sample(10)
  end

  def score
    @required = params[:letters]
    @answer = params[:answer]
    @url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    @uri = URI.open(@url)
    @check = JSON.parse(@uri.string)
    @found = @check['found']
    @chars = @answer.chars

    @result_message =
      if @found == true && @chars.all? { |char| @required.include? char }
        "You did it!!!! #{@answer.capitalize} is a word."
      elsif @found == false
        "That's not a word."
      else
        "You can't make '#{@answer}' from those letters."
      end
  end
end
