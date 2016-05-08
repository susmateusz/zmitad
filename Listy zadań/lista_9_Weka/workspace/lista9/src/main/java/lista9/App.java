package lista9;

import java.io.File;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import weka.core.Attribute;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffSaver;
import weka.core.converters.ConverterUtils.DataSource;

public class App {

	public static final double MAX_LOAN_VALUE = 900.0;

	public static void main(String... args) throws Exception {
		Instances instances = loadArffFile();
		removeSomeInstances(instances);
		removeAttribute(instances);
        saveToArffFile(instances);
	}

	public static void removeAttribute(Instances instances) {
		Attribute statusPozyczki = instances.attribute("status_pozyczki");
		instances.deleteAttributeAt(statusPozyczki.index());
	}

	public static void removeSomeInstances(Instances instances) {
		Attribute statusPozyczki = instances.attribute("status_pozyczki");
		Attribute kwotaKredytu = instances.attribute("kwota_kredytu");

		for (int i = instances.numInstances() - 1; i >= 0; i--) {
			Instance instance = instances.instance(i);
			if (isLoanRejected(instance, statusPozyczki) || loanTooGreat(kwotaKredytu, instance)) {
				instances.delete(i);
			}
		}
	}

	private static boolean loanTooGreat(Attribute kwotaKredytu, Instance instance) {
		return instance.value(kwotaKredytu) > MAX_LOAN_VALUE;
	}

	private static boolean isLoanRejected(Instance instance, Attribute statusPozyczki) {
		return instance.stringValue(statusPozyczki).equals("odmowa");
	}

	public static Instances loadArffFile() throws Exception {
		DataSource dataSource = new DataSource(
				"/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_9_Weka/12168104L2_2.arff");
		Instances instances = dataSource.getDataSet();
		return instances;
	}

    public static void saveToArffFile(Instances instances) throws IOException {
        ArffSaver arffSaver = new ArffSaver();
        arffSaver.setInstances(instances);
        arffSaver.setFile(new File("/home/mateusz/Studia/sem8/ZMiTAD/Listy zadań/lista_9_Weka/12168104L3_2.arff"));
        arffSaver.writeBatch();
    }

}
