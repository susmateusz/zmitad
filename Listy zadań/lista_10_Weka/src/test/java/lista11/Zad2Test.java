package lista11;

import org.junit.Before;
import org.junit.Test;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.functions.SMO;
import weka.classifiers.rules.JRip;
import weka.classifiers.rules.ZeroR;
import weka.classifiers.trees.J48;
import weka.core.matrix.Matrix;

import java.util.*;

/**
 * Created by mateusz on 21.05.16.
 * Zad2Test.
 */
public class Zad2Test {
    private static final int NUM_TESTS = 1;
    private static final int SEED = 10;

    private CrossValidator crossValidator;
    private int[] availableFolds;
    private Classifier[] availableClassifiers;

    @Before
    public void setUp() throws Exception {
        // dividers: 1, 3, 23, 29, 69, 87, 667, 2001
        String inputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/12168104L3_1.arff";
        crossValidator = new CrossValidator(inputFilename);
        availableFolds = new int[]{3, 23, 29,};
        availableClassifiers = new Classifier[]{
                new JRip(), new J48(), new SMO(), new NaiveBayes(), new ZeroR(), new MultilayerPerceptron()
        };
    }

    @Test
    public void testForAllClassifiers() throws FoldsCannotBeEqualException, Exception {
        // given
        for (Classifier classifier : availableClassifiers) {
            System.out.println("\nClassifier: " + classifier.toString());
            for (int numFolds : availableFolds) {
                Matrix matrix = crossValidator.runCrossValidation(classifier, numFolds, NUM_TESTS, SEED);
                Map<String, Double> stats = crossValidator.getStatistics(matrix);
                double GMean = stats.get("GMean");
                double AUC = stats.get("AUC");
                System.out.println("Folds:" + numFolds + "\tGMean = " + String.format("%.5f", GMean) + "\tAUC = " + String.format("%.5f", AUC));
                //System.out.println(Arrays.deepToString(matrix.getArray()));
            }
        }

    }

}
