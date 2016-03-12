class ListController < ApplicationController
  def index
     @idols = Idol.all
  end
  
end
