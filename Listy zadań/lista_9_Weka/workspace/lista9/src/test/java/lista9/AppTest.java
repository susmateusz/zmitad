package lista9;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.Collections;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;

public class AppTest {

	private Instances instances;
    private Attribute statusPozyczki;
    private Attribute kwotaKredytu;

	@Before
	public void setUp() throws Exception {
		instances = App.loadArffFile();
        statusPozyczki = instances.attribute("status_pozyczki");
        kwotaKredytu = instances.attribute("kwota_kredytu");
	}

    @Test
    public void testRemoveAttribute() {
        //given
        Set<Attribute> beforeAttributes = new HashSet<>(Collections.list(instances.enumerateAttributes()));
        //when
        App.removeAttribute(instances);
        Set<Attribute> afterAttributes = new HashSet<>(Collections.list(instances.enumerateAttributes()));
        beforeAttributes.removeAll(afterAttributes);
        //then
        assertEquals(1,beforeAttributes.size());
        assertEquals(statusPozyczki,beforeAttributes.iterator().next());
    }

	@Test
	public void testInstancesLoadedCorrectly(){
		//then
		assertNotNull(instances);
	}

	@Test
	public void testRemoveRecords() {
		//pre
		Set<Instance> instancesBefore = new HashSet<>();
		for (int i = 0; i < instances.numInstances(); i++) {
			instancesBefore.add(instances.instance(i));
		}
		// when
		App.removeSomeInstances(instances);
		// post
		Set<Instance> instancesAfter = new HashSet<>();
		for (int i = 0; i < instances.numInstances(); i++) {
			instancesAfter.add(instances.instance(i));
		}
		instancesBefore.removeAll(instancesAfter);
		// then
        for(Instance instance : instancesBefore)
		    assertTrue(loanTooGreat(instance)||isLoanRejected(instance));
	}

    private boolean loanTooGreat(Instance instance) {
        return instance.value(kwotaKredytu) > App.MAX_LOAN_VALUE;
    }

    private boolean isLoanRejected(Instance instance) {
        return instance.stringValue(statusPozyczki).equals("odmowa");
    }

}
