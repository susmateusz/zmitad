package lista11;

import weka.classifiers.AbstractClassifier;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.core.Instances;
import weka.core.Utils;
import weka.core.converters.ConverterUtils;
import weka.core.matrix.Matrix;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by mateusz on 21.05.16.
 */
public class CrossValidator {

    private Instances instances;
    public static int DEFAULT_SEED = 3;

    private CrossValidator() {

    }

    public CrossValidator(String filename) {
        try {
            instances = loadArffFile(filename);
            discretize();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void discretize() throws Exception {
        Discretize filter = new Discretize();
        filter.setInputFormat(instances);
        instances = Filter.useFilter(instances, filter);
    }

    public Instances loadArffFile(String filename) throws Exception {
        ConverterUtils.DataSource dataSource = new ConverterUtils.DataSource(
                filename);
        Instances instances = dataSource.getDataSet();
        instances.setClassIndex(instances.numAttributes() - 1);
        return instances;
    }

    public Instances randomize() {
        return randomize(DEFAULT_SEED);
    }

    public Instances randomize(int seed) {
        Instances randomized = new Instances(instances);
        randomized.randomize(new Random(seed));
        return randomized;
    }

    public Matrix evaluate(Instances randomized, Classifier classifier, int numFolds) throws Exception, FoldsCannotBeEqualException {
        if(instances.numInstances() % numFolds != 0)
            throw new FoldsCannotBeEqualException("Instances(length: "+instances.numInstances()+") cannot be divide into "+numFolds+" equal folds.");
        Evaluation eval = new Evaluation(randomized);
        for (int numFold = 0; numFold < numFolds; numFold++) {
            Instances train = randomized.trainCV(numFolds, numFold);
            Instances test = randomized.testCV(numFolds, numFold);
            Classifier clsCopy = AbstractClassifier.makeCopy(classifier);
            clsCopy.buildClassifier(train);
            eval.evaluateModel(clsCopy, test);
        }

        // output evaluation
        /*System.out.println();
        System.out.println(eval.toSummaryString("=== " + numFolds+ "-fold Cross-validation run " + DEFAULT_SEED + "===", false));
        System.out.println(Arrays.deepToString(eval.confusionMatrix()));

        Evaluation eval2 = new Evaluation(randomized);
        eval2.crossValidateModel(AbstractClassifier.makeCopy(classifier),randomized,numFolds,new Random(DEFAULT_SEED));
        System.out.println();
        System.out.println(eval2.toSummaryString("=== " + numFolds+ "-fold Cross-validation run " + DEFAULT_SEED + "===", false));
        System.out.println(Arrays.deepToString(eval2.confusionMatrix()));
        */
        return new Matrix(eval.confusionMatrix());
    }

    public Instances getInstances() {
        return instances;
    }

    public Matrix runCrossValidation(Classifier classifier, int numFolds, int numTests, int seed) throws Exception, FoldsCannotBeEqualException {
        Matrix totalConfusionMatrix = new Matrix(2,2);
        for(int n=0; n<numTests;n++){
            Matrix evaluatedConfusionMatrix = evaluate(randomize(seed+n),classifier,numFolds);
            //System.out.println("Test no. "+n+": "+Arrays.deepToString(evaluatedConfusionMatrix.getArray()));
            totalConfusionMatrix.plusEquals(evaluatedConfusionMatrix);
        }
        return averageMatrix(totalConfusionMatrix,numTests);
    }

    public Matrix averageMatrix(Matrix matrix, int tests) {
        return matrix.timesEquals(1.0/tests);
    }
    public Map<String,Double> getStatistics(Matrix matrix){
        Map<String,Double> stats = new HashMap<>();
        double [][] array = matrix.getArray();
        stats.put("Accuracy",getAccuracy(array));
        stats.put("TPrate",getTPrate(array));
        stats.put("TNrate",getTNrate(array));
        stats.put("GMean",getGMean(array));
        stats.put("AUC",getAUC(array));
        return stats;
    }

    public Double getAUC(double[][] matrix) {
        return (1+getTPrate(matrix)-getTNrate(matrix))/2.0;
    }

    public Double getGMean(double[][] matrix) {
        return Math.sqrt(getTPrate(matrix) * getTNrate(matrix));
    }

    public Double getTNrate(double[][] matrix) {
        return matrix[1][1]/(matrix[1][1]+matrix[1][0]);
    }

    public Double getTPrate(double[][] matrix) {
        return matrix[0][0]/(matrix[0][0]+matrix[0][1]);
    }

    public Double getAccuracy(double[][] matrix) {
        return (matrix[0][0]+matrix[1][1])/(matrix[0][0]+matrix[0][1]+matrix[1][0]+matrix[1][1]);
    }
}
