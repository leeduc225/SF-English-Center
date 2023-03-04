public class MapValue {
    public static void getMinMax(Map<String,Integer> newMap){
        FindValueMap find = new FindValueMap();
        System.debug('Min value: ' + find.getMin(newMap));
        System.debug('Max value: ' + find.getMax(newMap));
    }
}