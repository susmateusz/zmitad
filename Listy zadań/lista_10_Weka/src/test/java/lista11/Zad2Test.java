package lista11;

import org.junit.Before;
import org.junit.Test;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.core.matrix.Matrix;

import java.util.Arrays;
import java.util.Map;

/**
 * Created by mateusz on 21.05.16.
 */
public class Zad2Test {
    private static final Double ERROR = 0.01;
    private CrossValidator crossValidator;
    private double[][] array;
    private double TP,FN,FP,TN;

    @Before
    public void setUp() throws Exception {
        String inputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/test_lista_11_zad1.arff";
        crossValidator = new CrossValidator(inputFilename);
        TP = 1.0;
        FN = 3.0;
        FP = 5.0;
        TN = 7.0;
        array = new double[][]{{TP,FN},{FP,TN}};
    }
    @Test
    public void printForExampleData() throws FoldsCannotBeEqualException, Exception {
        // given
        Classifier classifier = new NaiveBayes();
        int numFolds = 4;
        int numTests = 10;
        int seed = 10;
        Matrix matrix = crossValidator.runCrossValidation(classifier, numFolds, numTests, seed);
        // when
        Map<String, Double> stats = crossValidator.getStatistics(matrix);
        // then
        System.out.println(Arrays.deepToString(matrix.getArray()));
        for(String key : stats.keySet()){
            System.out.println("key: "+key+"\t\tvalue:"+stats.get(key));
        }
    }

}
