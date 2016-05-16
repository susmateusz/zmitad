package lista10;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;

import javax.xml.parsers.DocumentBuilder;
import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;


/**
 * Created by mateusz on 15.05.16.
 */
public class Zad2 {

    public static final String SUM = "#SUM";
    static String inputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/12168104L3_1.arff";
    static String outputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/12168104L4_2_tmp.arff";
    static double LOG_BASE = 2;
    static int instancesNum = 0;

    public static void main(String... args) throws Exception {
        Instances instances = loadArffFile(inputFilename);
        instances = discretize(instances);
        // <Atrybut, wartosciTegoAtrybutu,WartosciAtrybutuDecyzyjnego,liczniki>
        Map<String, Map<String, Map<String, Double>>> data = getCountersFromInstances(instances);
        Map<String, Map<String,Double>> output = new HashMap<>();

        gainRatioAttributeEval(data);
        Map<String, Double> attributesEnthropies = getAttributesEnthropies(data);
        for(String key : attributesEnthropies.keySet()){
            Map<String,Double> enthropies = new HashMap<>();
            enthropies.put("hAttribute", attributesEnthropies.get(key));
            output.put(key,enthropies);
        }
        Map<String, Double> classEnthropies = getClassEnthropies(data);
        for(String key : classEnthropies.keySet()){
            Map<String,Double> enthropies = new HashMap<>();
            enthropies.put("hClass", classEnthropies.get(key));
            output.put(key,enthropies);
        }
        System.out.println(output);
        saveToArffFile(instances,outputFilename);
    }

    private static Map<String,Double> getClassEnthropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Double> classEntrophies = new HashMap<>();
        for(String key : data.keySet()){
            Map<String, Map<String, Double>> attrData = new HashMap<>(data.get(key));
            // pozbywanie się sumy - zostało {dobry, zły}
            //attrData.values().stream().forEach(map->map.remove(SUM));

            System.out.println(attrData.values());
            //System.out.println(attrData.values().stream().flatMap(map->map.values().stream()).collect(Collectors.toList()));
            //double classAttribute = attrData.values().stream().map(v->-v*log(v)).mapToDouble(Double::doubleValue).sum();
            //classEntrophies.put(key,hAttribute);
        }
        return classEntrophies;
    }

    private static Map<String,Double> getAttributesEnthropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Double> attributesEntrophies = new HashMap<>();
        for(String key : data.keySet()){
            List<Double> sums = data.get(key)
                    .values()
                    .stream()
                    .map(map->map.values()
                            .stream()
                            .mapToDouble(Double::doubleValue)
                            .sum()/instancesNum)
                    .collect(Collectors.toList());
            double hAttribute = sums.stream().map(v->-v*log(v)).mapToDouble(Double::doubleValue).sum();
            attributesEntrophies.put(key,hAttribute);
        }
        return attributesEntrophies;
    }

    private static Map<String, Map<String, Map<String, Double>>> getCountersFromInstances(Instances instances) {
        Map<String,Map<String,Map<String, Double>>> data = new HashMap<>();
        for(Attribute attribute : Collections.list(instances.enumerateAttributes())) {
            data.put(attribute.name(),getAttributeValuesCounters(instances,attribute));
        }
        return data;
    }

    private static Map<String,Map<String,Double>> getAttributeValuesCounters(Instances instances, Attribute attribute) {
        Map<String,Map<String,Double>> counters = new HashMap<>();
        Attribute classIndex = instances.attribute(instances.numAttributes() - 1);
        for(Object value : Collections.list(attribute.enumerateValues())) {
            // kluczami są wartości atrybutu decyzyjnego: {dobry, zły}
            Map<String, Double> classifiedValues = new HashMap<>();
            // zerowanie tabeli licznika odpowiedzi
            for(Object classIndexValue : Collections.list(classIndex.enumerateValues())){
                classifiedValues.put((String) classIndexValue,0.0);
            }
            for(Instance instance : Collections.list(instances.enumerateInstances())){
                if(instance.stringValue(attribute).equals(value)){
                    String valueOfClassIndexForInstance = instance.stringValue(classIndex);
                    classifiedValues.put(valueOfClassIndexForInstance,classifiedValues.get(valueOfClassIndexForInstance)+1);
                }
            }
            // changing counters to probabilities
            //double sum = classifiedValues.values().stream().mapToDouble(Double::valueOf).sum();
            //for(String key : classifiedValues.keySet()){
            //    classifiedValues.put(key,classifiedValues.get(key)/sum);
            //}
            //classifiedValues.put("#SUM",sum/instances.numInstances());
            counters.put((String) value,classifiedValues);
        }
        return counters;
    }

    private static Instances discretize(Instances instances) throws Exception {
        Discretize filter = new Discretize();
        filter.setInputFormat(instances);
        return Filter.useFilter(instances,filter);
    }

    public static double gainRatioAttributeEval(Map<String, Map<String, Map<String, Double>>> instances){
        //return infoGainAttributeEval(instances)/getAttributeEnthropy(instances);
        return 0;
    }

    private static double infoGainAttributeEval(Map<String, Map<String, Map<String, Double>>> instances){
        return 0;
    }

    private static double log(double num){
        return Math.log(num)/Math.log(LOG_BASE);
    }

    public static Instances loadArffFile(String filename) throws Exception {
        DataSource dataSource = new DataSource(
                filename);
        Instances instances = dataSource.getDataSet();
        instances.setClassIndex(instances.numAttributes() - 1);
        instancesNum = instances.numInstances();
        return instances;
    }

    public static void saveToArffFile(Instances instances, String filename) throws IOException {
        ArffSaver arffSaver = new ArffSaver();
        arffSaver.setInstances(instances);
        arffSaver.setFile(new File(filename));
        arffSaver.writeBatch();
    }

}
