package lista10;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;

import java.util.*;
import java.util.stream.Collectors;


/**
 * Created by mateusz on 15.05.16.
 * Lista 10. Zadanie 2.
 */
class Zad2 {

    static final String DEFAULT_INPUT_FILE = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/12168104L3_1.arff";
    static final double THRESHOLD = 0.001;

    static double LOG_BASE = 2;
    static int instancesNum = 0;

    public static void main(String... args) throws Exception {
        Instances instances = loadArffFile(DEFAULT_INPUT_FILE);
        instances = discretize(instances);
        // <Atrybut, wartosciTegoAtrybutu,WartosciAtrybutuDecyzyjnego,liczniki>
        Map<String, Map<String, Map<String, Double>>> data = getCountersFromInstances(instances);
        // <Atrybut, mapa z entropiami>
        Map<String, Map<String, Double>> output = getEntropies(data);

        gainRatioEval(output);
        infoGainEval(output);
        for (String key : output.keySet()) {
            System.out.println(key + " : " + output.get(key).get("gainRatio"));
        }
    }

    public static void gainRatioEval(Map<String, Map<String, Double>> entropies) {
        infoGainEval(entropies);
        for (String attribute : entropies.keySet()) {
            double infoGain = entropies.get(attribute).get("infoGain");
            double hAttribute = entropies.get(attribute).get("hAttribute");
            double entropy = (Math.abs(hAttribute)<THRESHOLD)? 0.0 : infoGain / hAttribute;
            entropies.get(attribute).put("gainRatio", entropy);
        }
    }

    public static void infoGainEval(Map<String, Map<String, Double>> entropies) {
        for (String attribute : entropies.keySet()) {
            entropies.get(attribute).put("infoGain", entropies.get(attribute).get("hClass") - entropies.get(attribute).get("hClassAttribute"));
        }
    }

    public static Map<String, Map<String, Double>> getEntropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Map<String, Double>> output = new HashMap<>();
        Map<String, Double> attributesEnthropies = getAttributesEnthropies(data);
        for (String key : attributesEnthropies.keySet()) {
            Map<String, Double> enthropies = new HashMap<>();
            enthropies.put("hAttribute", attributesEnthropies.get(key));
            output.put(key, enthropies);
        }
        Map<String, Double> classEnthropies = getClassEnthropies(data);
        for (String key : classEnthropies.keySet()) {
            output.get(key).put("hClass", classEnthropies.get(key));
        }
        Map<String, Double> classAttributeEnthropies = getClassAttributeEnthropies(data);
        for (String key : classAttributeEnthropies.keySet()) {
            output.get(key).put("hClassAttribute", classAttributeEnthropies.get(key));
        }
        return output;
    }

    public static Map<String, Double> getClassAttributeEnthropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Double> classAttributeEntrophies = new HashMap<>();
        // dla każdego atrybutu
        for (String key : data.keySet()) {
            // dla każdego atrybutu liczymy In i jego wagę w H_ClassAttribute
            for (String attrVal : data.get(key).keySet()) {
                double rowSum = data
                        .get(key)
                        .get(attrVal)
                        .values()
                        .stream()
                        .mapToDouble(Double::doubleValue)
                        .sum();
                double in = data
                        .get(key)
                        .get(attrVal)
                        .values()
                        .stream()
                        .map(v -> -v / rowSum * log(v / rowSum))
                        .mapToDouble(Double::doubleValue)
                        .sum();
                double weight = data
                        .get(key)
                        .get(attrVal)
                        .values()
                        .stream()
                        .map(v -> v / instancesNum)
                        .mapToDouble(Double::doubleValue)
                        .sum();
                double oldValue = (classAttributeEntrophies.get(key) != null) ? classAttributeEntrophies.get(key) : 0;
                classAttributeEntrophies.put(key, oldValue + in * weight);
            }
        }
        return classAttributeEntrophies;
    }

    public static Map<String, Double> getClassEnthropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Double> classEntrophies = new HashMap<>();
        for (String key : data.keySet()) {
            Map<String, Double> tmp = new HashMap<>();
            // sumowanie po ilosciach odpowiedzi {dobry, zły}
            for (Map<String, Double> val : data.get(key).values()) {
                for (String k : val.keySet()) {
                    double oldValue = (tmp.get(k) != null) ? tmp.get(k) : 0;
                    tmp.put(k, val.get(k) + oldValue);
                }
            }
            // normalizacja - podział przez wszystkie próbki
            for (String k : tmp.keySet()) {
                double oldValue = (tmp.get(k) != null) ? tmp.get(k) : 0;
                tmp.put(k, oldValue / instancesNum);
            }
            double classAttribute = tmp.values().stream().map(v -> -v * log(v)).mapToDouble(Double::doubleValue).sum();
            classEntrophies.put(key, classAttribute);
        }
        return classEntrophies;
    }

    public static Map<String, Double> getAttributesEnthropies(Map<String, Map<String, Map<String, Double>>> data) {
        Map<String, Double> attributesEntrophies = new HashMap<>();
        for (String key : data.keySet()) {
            List<Double> sums = data.get(key)
                    .values()
                    .stream()
                    .map(map -> map.values()
                            .stream()
                            .mapToDouble(Double::doubleValue)
                            .sum() / instancesNum)
                    .collect(Collectors.toList());
            double hAttribute = sums.stream().map(v -> -v * log(v)).mapToDouble(Double::doubleValue).sum();
            attributesEntrophies.put(key, hAttribute);
        }
        return attributesEntrophies;
    }

    public static Map<String, Map<String, Map<String, Double>>> getCountersFromInstances(Instances instances) {
        Map<String, Map<String, Map<String, Double>>> data = new HashMap<>();
        for (Attribute attribute : Collections.list(instances.enumerateAttributes())) {
            data.put(attribute.name(), getAttributeValuesCounters(instances, attribute));
        }
        return data;
    }

    private static Map<String, Map<String, Double>> getAttributeValuesCounters(Instances instances, Attribute attribute) {
        Map<String, Map<String, Double>> counters = new HashMap<>();
        Attribute classIndex = instances.attribute(instances.numAttributes() - 1);
        for (Object value : Collections.list(attribute.enumerateValues())) {
            // kluczami są wartości atrybutu decyzyjnego: {dobry, zły}
            Map<String, Double> classifiedValues = new HashMap<>();
            // zerowanie tabeli licznika odpowiedzi
            for (Object classIndexValue : Collections.list(classIndex.enumerateValues())) {
                classifiedValues.put((String) classIndexValue, 0.0);
            }
            for (Instance instance : Collections.list(instances.enumerateInstances())) {
                if (instance.stringValue(attribute).equals(value)) {
                    String valueOfClassIndexForInstance = instance.stringValue(classIndex);
                    classifiedValues.put(valueOfClassIndexForInstance, classifiedValues.get(valueOfClassIndexForInstance) + 1);
                }
            }
            // changing counters to probabilities
            //double sum = classifiedValues.values().stream().mapToDouble(Double::valueOf).sum();
            //for(String key : classifiedValues.keySet()){
            //    classifiedValues.put(key,classifiedValues.get(key)/sum);
            //}
            //classifiedValues.put("#SUM",sum/instances.numInstances());
            counters.put((String) value, classifiedValues);
        }
        return counters;
    }

    public static Instances discretize(Instances instances) throws Exception {
        Discretize filter = new Discretize();
        filter.setInputFormat(instances);
        return Filter.useFilter(instances, filter);
    }

    public static double log(double num) {
        return (Math.abs(num)<THRESHOLD) ? 0.0 : Math.log(num) / Math.log(LOG_BASE);
    }

    public static Instances loadArffFile(String filename) throws Exception {
        DataSource dataSource = new DataSource(
                filename);
        Instances instances = dataSource.getDataSet();
        instances.setClassIndex(instances.numAttributes() - 1);
        instancesNum = instances.numInstances();
        return instances;
    }

}
