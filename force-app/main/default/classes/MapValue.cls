public class MapValue {
    public static void getMin(Map<String,Integer> newMap){
        FindValueMap find = new FindValueMap();
        find.getMin(newMap);
        System.debug('Min value:' + find.getMin(newMap));
    }
}