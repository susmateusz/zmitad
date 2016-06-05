package projekt;

import lista11.CrossValidator;
import lista11.FoldsCannotBeEqualException;
import org.junit.Before;
import org.junit.Test;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.trees.J48;
import weka.core.matrix.Matrix;

import java.util.Map;

/**
 * Created by mateusz on 05.06.16.
 */
public class ProjectTest {

    private String inputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/Projekt/Dane/SWDnominals.arff";
    private CrossValidator crossValidator;
    private Classifier[] availableClassifiers;
    private int[] availableFolds;

    @Before
    public void setUp(){
        crossValidator = new CrossValidator(inputFilename);
        availableFolds = new int[]{2,5,10};
        availableClassifiers = new Classifier[] {
                new NaiveBayes(), new J48()
        };
    }

    @Test
    public void testForAllClassifiers() throws FoldsCannotBeEqualException, Exception {
        //given
        int NUM_TESTS = 10;
        int SEED = 3;
        // when
        for (Classifier classifier : availableClassifiers) {
            System.out.println("\nClassifier: " + classifier.toString());
            for (int numFolds : availableFolds) {
                Matrix matrix = crossValidator.runCrossValidation(classifier, numFolds, NUM_TESTS, SEED);
                Map<String, Double> stats = crossValidator.getStatistics(matrix);
                double GMean = stats.get("GMean");
                double AUC = stats.get("AUC");
                System.out.println("Folds:" + numFolds + "\tGMean = " + String.format("%.5f", GMean) + "\tAUC = " + String.format("%.5f", AUC));
            }
        }
    }
}
