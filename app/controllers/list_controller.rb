class ListController < ApplicationController
  
  def home
    
  end
  
  def search
     @productionorunit = Idol.select(:productionorunit).distinct.order(productionorunit: :asc)
     @idols = Idol.all.order(nameko: :asc)
     
     #신장
     @heightMinRangeArray = rangeArray('height', 5, 0)
     @heightMaxRangeArray = rangeArray('height', 5, 1)
     #체중
     @weightMinRangeArray = rangeArray('weight', 5, 0)
     @weightMaxRangeArray = rangeArray('weight', 5, 1)
     #b
     @bMinRangeArray = rangeArray('b', 5, 0)
     @bMaxRangeArray = rangeArray('b', 5, 1)
     #w
     @wMinRangeArray = rangeArray('w', 5, 0)
     @wMaxRangeArray = rangeArray('w', 5, 1)
     #h
     @hMinRangeArray = rangeArray('h', 5, 0)
     @hMaxRangeArray = rangeArray('h', 5, 1)
     
  end
  
  def result
    
    @idols = Idol.all.order(nameko: :asc).distinct
    
    #성별
    if params[:gender] != ""
      @idols = @idols.where('gender = ?', params[:gender])
    end
    
    ##{'6-8세'=>'6-8','9-11세'=>'9-11','12-14세'=>'12-14','15-17세'=>'15-17','18-19세'=>'18-19','20-24세'=>'20-24','25-29세'=>'25-29','30-34세'=>'30-34','35-40세'=>'35-40'}
    
    #연령
    @ageMMarray = params[:age].split('-')
    @ageUnknown = params[:ageUnknown].to_i
    if !@ageUnknown
      @idols = @idols.where('age >= 0')
    end
    if params[:age] != "" and params[:age] != '5-41'
      @idols = @idols.where('age >= ? AND age <= ? OR age < 0', @ageMMarray[0], @ageMMarray[1])
    elsif params[:age] == '5-41'
      @idols = @idols.where('age <= ? OR age >= ?', @ageMMarray[0], @ageMMarray[1])
    else
    end
    
    #신장
    @heightUnknown = params[:heightUnknown].to_i
    if !@heightUnknown
      @idols = @idols.where('height >= 0')
    end
    @idols = @idols.where('height >= ? AND height < ? OR height < 0', params[:heightMin], params[:heightMax])
    
    #체중
    @weightUnknown = params[:weightUnknown].to_i
    if !@weightUnknown
      @idols = @idols.where('weight >= 0')
    end
    @idols = @idols.where('weight >= ? AND weight < ? OR weight < 0', params[:weightMin], params[:weightMax])
    
    #b
    @bwhUnknown = params[:bwhUnknown].to_i
    if !@bwhUnknown
      @idols = @idols.where('b >= 0 AND w >= 0 AND h >= 0')
    end
    @idols = @idols.where('b >= ? AND b < ? OR b < 0', params[:bMin], params[:bMax])
    
    #w
    @idols = @idols.where('w >= ? AND w < ? OR w < 0', params[:wMin], params[:wMax])
    
    #h
    @idols = @idols.where('h >= ? AND h < ? OR h < 0', params[:hMin], params[:hMax])
    
    #소속사
    if params[:productionorunit] != ""
      #@idols = Idol.where(productionorunit: params[:productionorunit])
      @idols = @idols.where('productionorunit = ? OR productionorunit2 = ?', params[:productionorunit], params[:productionorunit])
    end
  end
end

#현재 search버튼을 누를 경우에, list/result로 접근하면  list controller result action으로 리디렉팅하고, 해당 액션은 변수 계산후 그것을 search.html.erb에 뿌리는 방식으로 구동
#원래대로 돌리려면, def result의 @productionorunit을 지우고, render action: 'search'를 render action: 'index'로 수정하여야 함.
#def search에서 @Idols 삭제해야함
