package lista10;

import org.junit.Before;
import org.junit.Test;
import weka.core.Instances;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.closeTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;

/**
 * Created by mateusz on 18.05.16.
 */
public class Zad2Test {

    private Instances instances;
    private Map<String, Map<String, Map<String, Double>>> data;
    private String inputFilename = "/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_10_Weka/test.arff";

    @Before
    public void setUp() throws Exception {
        instances = Zad2.discretize(Zad2.loadArffFile(inputFilename));
        data = Zad2.getCountersFromInstances(instances);
    }

    @Test
    public void testInstancesLoaded() {
        assertNotNull(instances);
        assertEquals(14,Zad2.instancesNum);
    }

    @Test
    public void testGetCountersFromInstances() {
        assertNotNull(data);
        assertFalse(data.isEmpty());
    }

    @Test
    public void testAttributeEntropies() {
        // given
        double expected = -5.0 / 14.0 * Zad2.log(5.0 / 14.0) - 4.0 / 14.0 * Zad2.log(4.0 / 14.0) - 5.0 / 14.0 * Zad2.log(5.0 / 14.0);
        double epsilon = 0.01;
        // when
        Map<String, Double> attributesEntropies = Zad2.getAttributesEnthropies(data);
        // then
        assertThat(attributesEntropies.get("wiek").doubleValue(), closeTo(expected, epsilon));
    }

    @Test
    public void testClassEntropies() {
        // given
        double expected = -9.0 / 14.0 * Zad2.log(9.0 / 14.0) - 5.0 / 14.0 * Zad2.log(5.0 / 14.0);
        double epsilon = 0.01;
        // when
        Map<String, Double> classEntropies = Zad2.getClassEnthropies(data);
        // then
        assertThat(classEntropies.get("wiek").doubleValue(), closeTo(expected, epsilon));
    }

    @Test
    public void testClassAttributeEntropies() {
        // given
        double I1 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double I2 = -4.0 / 4.0 * Zad2.log(4.0 / 4.0) - 0.0 / 4.0 * Zad2.log(0.0 / 4.0);
        double I3 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double E = 5.0/14.0*I1+4.0/14.0*I2+5.0/14.0*I3;
        double epsilon = 0.01;
        // when
        Map<String, Double> classAttributeEntropies = Zad2.getClassAttributeEnthropies(data);
        // then
        assertThat(classAttributeEntropies.get("wiek").doubleValue(), closeTo(E, epsilon));
    }

    @Test
    public void testinfoGainEval() {
        // given
        double I0= -9.0 / 14.0 * Zad2.log(9.0 / 14.0) - 5.0 / 14.0 * Zad2.log(5.0 / 14.0);
        double I1 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double I2 = -4.0 / 4.0 * Zad2.log(4.0 / 4.0) - 0.0 / 4.0 * Zad2.log(0.0 / 4.0);
        double I3 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double E = 5.0/14.0*I1+4.0/14.0*I2+5.0/14.0*I3;
        double expectedInfoGain = I0-E;
        double epsilon = 0.01;
        // when
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.infoGainEval(output);
        // then
        assertThat(output.get("wiek").get("infoGain"), closeTo(expectedInfoGain, epsilon));
    }

    @Test
    public void testGainRatioEval() {
        // given
        double I0= -9.0 / 14.0 * Zad2.log(9.0 / 14.0) - 5.0 / 14.0 * Zad2.log(5.0 / 14.0);
        double I1 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double I2 = -4.0 / 4.0 * Zad2.log(4.0 / 4.0) - 0.0 / 4.0 * Zad2.log(0.0 / 4.0);
        double I3 = -2.0 / 5.0 * Zad2.log(2.0 / 5.0) - 3.0 / 5.0 * Zad2.log(3.0 / 5.0);
        double E = 5.0/14.0*I1+4.0/14.0*I2+5.0/14.0*I3;
        double hAttribute = -5.0 / 14.0 * Zad2.log(5.0 / 14.0) - 4.0 / 14.0 * Zad2.log(4.0 / 14.0) - 5.0 / 14.0 * Zad2.log(5.0 / 14.0);
        double expectedInfoGain = (I0-E)/hAttribute;
        double epsilon = 0.01;
        // when
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.gainRatioEval(output);
        // then
        assertThat(output.get("wiek").get("gainRatio"), closeTo(expectedInfoGain, epsilon));
    }






}
