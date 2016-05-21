package lista11;

import org.junit.Before;
import org.junit.Test;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.matrix.Matrix;

import java.util.*;
import java.util.stream.Collectors;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.within;
import static org.junit.Assert.assertTrue;

/**
 * Created by mateusz on 21.05.16.
 * Zad1Test.
 */
public class Zad1Test {

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
    public void testLoadFromFilename() {
        assertThat(crossValidator.getInstances())
                .isNotNull();
    }

    @Test
    public void testRandomizeData() {
        // given
        int randomSeed = 5;
        List<String> expected = crossValidator.getInstances()
                .stream()
                .map(Instance::toString)
                .collect(Collectors.toList());
        // when
        Instances randomized = crossValidator.randomize(randomSeed);
        List<String> result = randomized.stream()
                .map(Instance::toString)
                .collect(Collectors.toList());
        // then
        assertThat(randomized)
                .isNotNull();
        assertThat(result)
                .hasSize(expected.size())
                .containsExactlyInAnyOrder(expected.toArray(new String[expected.size()]));
    }

    @Test
    public void testRandomizedDataAreDifferentForDifferentSeeds() {
        // given
        int seed1 = 1;
        int seed2 = 2;
        // when
        List<String> result1 = crossValidator.randomize(seed1).stream()
                .map(Instance::toString)
                .collect(Collectors.toList());
        List<String> result2 = crossValidator.randomize(seed2).stream()
                .map(Instance::toString)
                .collect(Collectors.toList());
        // then
        assertThat(result1)
                .containsExactlyInAnyOrder(result2.toArray(new String[result2.size()]))
                .isNotEqualTo(result2);
    }

    @Test
    public void testEvaluate() throws Exception, FoldsCannotBeEqualException {
        // given
        Classifier classifier = new NaiveBayes();
        Instances randomized = crossValidator.randomize();
        int numFolds = 4;
        // when
        Matrix result = crossValidator.evaluate(randomized, classifier, numFolds);
        assertThat(result)
                .isNotNull();
    }

    @Test
    public void testCrossValidation() throws Exception, FoldsCannotBeEqualException {
        // given
        Classifier classifier = new NaiveBayes();
        int numFolds = 4;
        int numTests = 10;
        int seed = 10;
        // when
        Matrix result = crossValidator.runCrossValidation(classifier, numFolds, numTests, seed);
        double[][] resultArray = result.getArray();
        Double sum = 0.0;
        for (double[] row : resultArray) {
            for (double cell : row) {
                sum += cell;
            }
        }
        // then
        assertThat(result)
                .isNotNull();
        assertTrue(Math.abs(sum-crossValidator.getInstances().numInstances())<0.01);
        // System.out.println("Total: " + Arrays.deepToString(result.getArray()));
    }

    @Test
    public void testAccuracy(){
        // given
        Double expected = (TP+TN)/(TP+FN+FP+TN);
        // when
        Double result = crossValidator.getAccuracy(array);
        // then
        assertThat(result)
                .isNotNull()
                .isCloseTo(expected,within(ERROR));
    }

    @Test
    public void testTPrate(){
        // given
        Double expected = (TP)/(TP+FN);
        // when
        Double result = crossValidator.getTPrate(array);
        // then
        assertThat(result)
                .isNotNull()
                .isCloseTo(expected,within(ERROR));
    }

    @Test
    public void testTNrate(){
        // given
        Double expected = (TN)/(TN+FP);
        // when
        Double result = crossValidator.getTNrate(array);
        // then
        assertThat(result)
                .isNotNull()
                .isCloseTo(expected,within(ERROR));
    }

    @Test
    public void testGMean(){
        // given
        Double expected = Math.sqrt(((TP)/(TP+FN))*((TN)/(TN+FP)));
        // when
        Double result = crossValidator.getGMean(array);
        // then
        assertThat(result)
                .isNotNull()
                .isCloseTo(expected,within(ERROR));
    }

    @Test
    public void testAUC(){
        // given
        Double expected = (1+(TP)/(TP+FN)-(TN)/(TN+FP))/2;
        // when
        Double result = crossValidator.getAUC(array);
        // then
        assertThat(result)
                .isNotNull()
                .isCloseTo(expected,within(ERROR));
    }

    @Test
    public void testStatistics() throws FoldsCannotBeEqualException, Exception {
        // given
        Classifier classifier = new NaiveBayes();
        int numFolds = 4;
        int numTests = 10;
        int seed = 10;
        Matrix matrix = crossValidator.runCrossValidation(classifier, numFolds, numTests, seed);
        // when
        Map<String, Double> stats = crossValidator.getStatistics(matrix);
        // then
        assertThat(stats)
                .isNotNull()
                .isNotEmpty()
                .containsKeys("Accuracy","TPrate","TNrate","GMean","AUC")
                .doesNotContainValue(null);
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
