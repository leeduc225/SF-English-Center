public class FindValueMap extends FindValue{
    public override Integer getMin(Map<String,Integer> newMap){
        Integer minValue;
        if(newMap.size() < 1){
            return null;
        }
        Integer count = 0;
        for(Integer var : newMap.values()){
            count ++;
            if(count == 1)
                minValue = var;
            if(minValue > var)
            minValue = var;
        }
        return minValue;
    }
    public override Integer getMax(Map<String,Integer> newMap){
        Integer maxValue;
        if(newMap.size() < 1){
            return null;
        }
        Integer count = 0;
        for(Integer var : newMap.values()){
            count ++;
            if(count == 1)
                maxValue = var;
            if(maxValue < var)
            maxValue = var;
        }
        return maxValue;
    }
}