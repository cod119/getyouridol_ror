class ListController < ApplicationController
  def index
     @idols = Idol.all
  end
  
  def search
     @productionorunit = Idol.select(:productionorunit).distinct
     @idol = Idol.new
     @idols = Idol.all
  end
  
  def result
    @productionorunit = Idol.select(:productionorunit).distinct
    @idols = Idol.all
    
    #성별
    if params[:gender] != ""
      @idols = @idols.where('gender = ?', params[:gender])
    end
    
    #소속사
    if params[:productionorunit] != ""
      #@idols = Idol.where(productionorunit: params[:productionorunit])
      @idols = @idols.where('productionorunit = ? OR productionorunit2 = ?', params[:productionorunit], params[:productionorunit])
    end
    render action: 'search'
  end
end

#현재 search버튼을 누를 경우에, list/result로 접근하면  list controller result action으로 리디렉팅하고, 해당 액션은 변수 계산후 그것을 search.html.erb에 뿌리는 방식으로 구동
#원래대로 돌리려면, def result의 @productionorunit을 지우고, render action: 'search'를 render action: 'index'로 수정하여야 함.
#def search에서 @Idols 삭제해야함
