class ListController < ApplicationController
  def index
     @idols = Idol.all
  end
  
  def search
     @productionorunit = Idol.select(:productionorunit).distinct.order(productionorunit: :asc)
     @idol = Idol.new
     @idols = Idol.all.order(nameko: :asc)
     
     #신장
     @heightRangeArrayRaw = Idol.select(:height).distinct.pluck(:height).flatten
     @heightMinRaw = (@heightRangeArrayRaw.min / 5).floor
     @heightMaxRaw = (@heightRangeArrayRaw.max / 5).floor
     @heightMinRangeArray = {}
     for val in (@heightMinRaw..@heightMaxRaw)
       @heightMinRangeArray[val*5] = val*5
     end
     @heightMinRangeArrayValue = @heightMinRangeArray.values
     @heightMaxRangeArray = {}
     for val in (@heightMinRaw+1..@heightMaxRaw+1)
       @heightMaxRangeArray[val*5] = val*5
     end
     @heightMaxRangeArrayValue = @heightMaxRangeArray.values
  end
  
  def result
    @productionorunit = Idol.select(:productionorunit).distinct.order(productionorunit: :asc)
    @idols = Idol.all.order(nameko: :asc)
    
    #성별
    if params[:gender] != ""
      @idols = @idols.where('gender = ?', params[:gender])
    end
    
    ##{'6-8세'=>'6-8','9-11세'=>'9-11','12-14세'=>'12-14','15-17세'=>'15-17','18-19세'=>'18-19','20-24세'=>'20-24','25-29세'=>'25-29','30-34세'=>'30-34','35-40세'=>'35-40'}
    
    #연령
    @ageMMarray = params[:age].split('-')
    if params[:age] != "" and params[:age] != '5-41'
      @idols = @idols.where('age >= ? AND age <= ?', @ageMMarray[0], @ageMMarray[1])
    elsif params[:age] == '5-41'
      @idols = @idols.where('age <= ? OR age >= ?', @ageMMarray[0], @ageMMarray[1])
    else
    end
    
    #신장
    @idols = @idols.where('height >= ? AND height <= ?', params[:heightMin], params[:heightMax])
    
    #소속사
    if params[:productionorunit] != ""
      #@idols = Idol.where(productionorunit: params[:productionorunit])
      @idols = @idols.where('productionorunit = ? OR productionorunit2 = ?', params[:productionorunit], params[:productionorunit])
    end
    render action: 'index'
  end
end

#현재 search버튼을 누를 경우에, list/result로 접근하면  list controller result action으로 리디렉팅하고, 해당 액션은 변수 계산후 그것을 search.html.erb에 뿌리는 방식으로 구동
#원래대로 돌리려면, def result의 @productionorunit을 지우고, render action: 'search'를 render action: 'index'로 수정하여야 함.
#def search에서 @Idols 삭제해야함
