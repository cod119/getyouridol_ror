class ListController < ApplicationController
  def index
     @idols = Idol.all
  end
  
  def search
     @productionorunit = Idol.select(:productionorunit).distinct
     @idol = Idol.new
  end
  
  def result
    if params[:productionorunit] == ""
      @idols = Idol.all
    else
      #@idols = Idol.where(productionorunit: params[:productionorunit])
      @idols = Idol.where('productionorunit = ? OR productionorunit2 = ?', params[:productionorunit], params[:productionorunit])
    end
    render action: 'index'
  end
end
