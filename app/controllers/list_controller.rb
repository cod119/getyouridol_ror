class ListController < ApplicationController
  
  def home
    
  end
  
  def search
     
     #postgreSQL에서는 order로 한글을 정렬할 수가 없어서 order('nameko collate "C" asc')로 대체
     @idols = Idol.all.order(nameko: :asc)
     #@idols = Idol.all.order('nameko collate "C" asc')
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
     #소속사
     @productionorunit = Idol.select(:productionorunit).distinct.order(productionorunit: :asc)
     #hairstyle
     @hairstyle = nonRangeArray('hairstyle', 0)
     @hairstyle2 = (nonRangeArray('hairstyle2', 0) + nonRangeArray('hairstyle3', 0)).uniq
     @hairstyle3 = @hairstyle2
     #feature
     @feature = (nonRangeArray('feature', 0) + nonRangeArray('feature2', 0) + nonRangeArray('feature3', 0)).uniq
     #소속사2
     @mediafromp = Idol.select(:mediafromp).distinct.order(mediafromp: :asc).pluck(:mediafromp)
     @mediafromp_1 = {}
     @mediafromp.each do |v|
       one = Idol.where('mediafromp = ?', v).select(:productionorunit).distinct.order(productionorunit: :asc).pluck(:productionorunit)
       two = Idol.where('mediafromp = ?', v).select(:productionorunit2).distinct.order(productionorunit2: :asc).pluck(:productionorunit2)
       total = (one + two).uniq
       @mediafromp_1[v.to_sym] = total.select {|l| l != "0"}
     end
     
  end
  
  def result
    
    @idols = Idol.all.distinct
    
    #성별
    if params[:gender] != ""
      @idols = @idols.where('gender = ?', params[:gender])
    end
    
    ##{'6-8세'=>'6-8','9-11세'=>'9-11','12-14세'=>'12-14','15-17세'=>'15-17','18-19세'=>'18-19','20-24세'=>'20-24','25-29세'=>'25-29','30-34세'=>'30-34','35-40세'=>'35-40'}
    
    #연령
    @ageMMarray = params[:age].split('-')
    @ageUnknown = params[:ageUnknown].to_i
    if !@ageUnknown != 1
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
    if !@heightUnknown != 1
      @idols = @idols.where('height >= 0')
    end
    @idols = @idols.where('height >= ? AND height < ? OR height < 0', params[:heightMin], params[:heightMax])
    
    #체중
    @weightUnknown = params[:weightUnknown].to_i
    if @weightUnknown != 1
      @idols = @idols.where('weight >= 0')
    end
    @idols = @idols.where('weight >= ? AND weight < ? OR weight < 0', params[:weightMin], params[:weightMax])
    
    #b
    @bwhUnknown = params[:bwhUnknown].to_i
    if !@bwhUnknown != 1
      @idols = @idols.where('b >= 0 AND w >= 0 AND h >= 0')
    end
    @idols = @idols.where('b >= ? AND b < ? OR b < 0', params[:bMin], params[:bMax])
    
    #w
    @idols = @idols.where('w >= ? AND w < ? OR w < 0', params[:wMin], params[:wMax])
    
    #h
    @idols = @idols.where('h >= ? AND h < ? OR h < 0', params[:hMin], params[:hMax])
    
    #소속사
      #뮤즈는 따옴표(')를 쓰기 때문에 where 조건문에서 조건을 쌍따옴표로 감싸거나, params를 .to_s해야.
    if params[:productionorunit] != ""
      #@idols = Idol.where(productionorunit: params[:productionorunit])
      @idols = @idols.where("productionorunit = ? OR productionorunit2 = ?", params[:productionorunit], params[:productionorunit])
    end
    
    #헤어스타일
    if params[:hairstyle] != ""
      @idols = @idols.where('hairstyle = ?', params[:hairstyle])
    end
    if params[:hairstyle2] != ""
      @idols = @idols.where('hairstyle2 = ? OR hairstyle3 = ?', params[:hairstyle2], params[:hairstyle2])
    end
    if params[:hairstyle3] != ""
      @idols = @idols.where('hairstyle2 = ? OR hairstyle3 = ?', params[:hairstyle3], params[:hairstyle3])
    end
    
    #기타특징
    if params[:feature] != ""
      @idols = @idols.where('feature = ? OR feature2 = ? OR feature3 = ?', params[:feature], params[:feature], params[:feature])
    end
    if params[:feature2] != ""
      @idols = @idols.where('feature = ? OR feature2 = ? OR feature3 = ?', params[:feature2], params[:feature2], params[:feature2])
    end
    if params[:feature3] != ""
      @idols = @idols.where('feature = ? OR feature2 = ? OR feature3 = ?', params[:feature3], params[:feature3], params[:feature3])
    end
    
    #소속사2
      #뮤즈는 따옴표(')를 쓰기 때문에 where 조건문에서 조건을 쌍따옴표로 감싸거나, params를 .to_s해야.
    def production_filter(rawData, targetcolumns, keyArray)
      
      @all_key_array = []
      for @j_prod in targetcolumns
        @all_key_array = @all_key_array + Idol.select(@j_prod.to_sym).distinct.pluck(@j_prod.to_sym)
      end
      @all_key_array = @all_key_array.uniq
      @all_key_array.select! {|v| v != "0"}
      @notKeyArray = @all_key_array
      if keyArray
        @notKeyArray = @notKeyArray - keyArray
      end
      for @i_prod in @notKeyArray
        
          rawData = rawData.where.not("productionorunit = ? OR productionorunit2 = ?", @i_prod.to_s, @i_prod.to_s)
        
      end
      return rawData
    end
    @idols = production_filter(@idols, ['productionorunit', 'productionorunit2'], params[:productionorunit_multisel])


    @idols = @idols.order('nameko: collate "C"')
  end
  
  def about
    
  end
  
end

#현재 search버튼을 누를 경우에, list/result로 접근하면  list controller result action으로 리디렉팅하고, 해당 액션은 변수 계산후 그것을 search.html.erb에 뿌리는 방식으로 구동
#원래대로 돌리려면, def result의 @productionorunit을 지우고, render action: 'search'를 render action: 'index'로 수정하여야 함.
#def search에서 @Idols 삭제해야함
