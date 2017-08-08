require 'interface.rb'


class GameController < ApplicationController
  def game
    @grid = grid
    @start_time = Time.now
  end

  def score

    @guess = params[:word]
    @grid = params[:grid]
    @start_time = params[:start_time].to_datetime
    @end_time = Time.now
    @result = run_game(@guess, @grid, @start_time, @end_time)
  end
end
