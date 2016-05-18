package lista10;

import org.junit.Before;
import org.junit.Test;
import weka.core.Instances;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.closeTo;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * Created by mateusz on 18.05.16.
 * Testy dla prawdziwego pliku z danymi.
 */
public class Zad2_12168104L3_1Test {

    private Instances instances;
    private Map<String, Map<String, Map<String, Double>>> data;
    private Map<String, Double> wekaOutput;

    @Before
    public void setUp() throws Exception {
        instances = Zad2.discretize(Zad2.loadArffFile(Zad2.DEFAULT_INPUT_FILE));
        data = Zad2.getCountersFromInstances(instances);
        wekaOutput = new HashMap<>();
        wekaOutput.put("miesieczny_dochod_netto", 0.12656);
        wekaOutput.put("okres_w_jakim_pobierał_dochód", 0.05201);
        wekaOutput.put("ktore_rolowanie", 0.04111);
        wekaOutput.put("okres_w_jakim_będzie_pobierał_dochód", 0.01521);
        wekaOutput.put("wiek", 0.00931);
        wekaOutput.put("płeć", 0.00826);
        wekaOutput.put("rodzaj_źródła_dochodu", 0.0);
        wekaOutput.put("kwota_kredytu", 0.0);

    }

    @Test
    public void testInstancesLoaded() {
        assertNotNull(instances);
        assertEquals(2001, Zad2.instancesNum);
    }

    @Test
    public void testGainRatioEvalForLogBaseEqual2() {
        //given
        // when
        Zad2.LOG_BASE = 2;
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.gainRatioEval(output);
        // then
        for (String attr : wekaOutput.keySet()) {
            assertThat(output.get(attr).get("gainRatio"), closeTo(wekaOutput.get(attr), Zad2.THRESHOLD));
        }
    }

    @Test
    public void testGainRatioEvalForLogBaseEqualE() {
        //given
        Map<String, Double> wekaOutput = new HashMap<>();
        wekaOutput.put("miesieczny_dochod_netto", 0.12656);
        wekaOutput.put("okres_w_jakim_pobierał_dochód", 0.05201);
        wekaOutput.put("ktore_rolowanie", 0.04111);
        wekaOutput.put("okres_w_jakim_będzie_pobierał_dochód", 0.01521);
        wekaOutput.put("wiek", 0.00931);
        wekaOutput.put("płeć", 0.00826);
        wekaOutput.put("rodzaj_źródła_dochodu", 0.0);
        wekaOutput.put("kwota_kredytu", 0.0);
        // when
        Zad2.LOG_BASE = Math.E;
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.gainRatioEval(output);
        // then
        for (String attr : wekaOutput.keySet()) {
            assertThat(output.get(attr).get("gainRatio"), closeTo(wekaOutput.get(attr), Zad2.THRESHOLD));
        }
    }

    @Test
    public void testInfoGainEvalForLogBaseEqual2() {
        //given
        Map<String, Double> wekaOutput = new HashMap<>();
        wekaOutput.put("miesieczny_dochod_netto", 0.01825);
        wekaOutput.put("okres_w_jakim_pobierał_dochód", 0.02118);
        wekaOutput.put("ktore_rolowanie", 0.03754);
        wekaOutput.put("okres_w_jakim_będzie_pobierał_dochód", 0.00837);
        wekaOutput.put("wiek", 0.02025);
        wekaOutput.put("płeć", 0.00802);
        wekaOutput.put("rodzaj_źródła_dochodu", 0.0);
        wekaOutput.put("kwota_kredytu", 0.0);
        // when
        Zad2.LOG_BASE = 2;
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.infoGainEval(output);
        // then
        for (String attr : wekaOutput.keySet()) {
            assertThat(output.get(attr).get("infoGain"), closeTo(wekaOutput.get(attr), Zad2.THRESHOLD));
        }
    }

    /**
     * Test sprawdza, czy wyniki się różnią od poprzedniego. JEżeli tak, to po przeskalowaniu będą takie same
     */
    @Test
    public void testInfoGainEvalForLogBaseEqualE() {
        //given
        Map<String, Double> wekaOutput = new HashMap<>();
        wekaOutput.put("miesieczny_dochod_netto", 0.01825);
        wekaOutput.put("okres_w_jakim_pobierał_dochód", 0.02118);
        wekaOutput.put("ktore_rolowanie", 0.03754);
        wekaOutput.put("okres_w_jakim_będzie_pobierał_dochód", 0.00837);
        wekaOutput.put("wiek", 0.02025);
        wekaOutput.put("płeć", 0.00802);
        wekaOutput.put("rodzaj_źródła_dochodu", 0.0);
        wekaOutput.put("kwota_kredytu", 0.0);
        // when
        Zad2.LOG_BASE = Math.E;
        Map<String, Map<String, Double>> output = Zad2.getEntropies(data);
        Zad2.infoGainEval(output);
        // then
        for (String attr : wekaOutput.keySet()) {
            assertThat(output.get(attr).get("infoGain") / Zad2.log(2.0), closeTo(wekaOutput.get(attr), Zad2.THRESHOLD));
        }
    }


}
