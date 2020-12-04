//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick 2.8
import QtQuick.Layouts 1.3
import JASP.Controls 1.0
import JASP.Widgets 1.0


Form
{
	plotHeight: 240
	plotWidth:  320
	
	CheckBox { name: "standardizedEffectSize"; checked: true; visible: false }
	
	VariablesForm
	{
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight
		AvailableVariablesList { name: "allVariablesList" }		
		AssignedVariablesList { name: "variables"; title: qsTr("Variables"); suggestedColumns: ["scale"] }
	}
	
	DoubleField { name: "testValue"; label: qsTr("Test value:"); defaultValue: 0; negativeValues: true }

	Group
	{
		title: qsTr("Plots")
		Layout.rowSpan: 3

		CheckBox
		{
			name: "plotPriorAndPosterior";		label: qsTr("Prior and posterior")
			CheckBox { name: "plotPriorAndPosteriorAdditionalInfo";		label: qsTr("Additional info"); checked: true }
			CIField  { name: "priorAndPosteriorPlotsCredibleInterval";	label: qsTr("Credible interval") }
		}

		CheckBox
		{
			enabled: student.checked && priors.defaultPriorsChecked
			name: "plotBayesFactorRobustness";	label: qsTr("Bayes factor robustness check")
			CheckBox { name: "plotBayesFactorRobustnessAdditionalInfo";	label: qsTr("Additional info"); checked: true }
		}

		CheckBox
		{
			enabled: student.checked && priors.defaultPriorsChecked
			name: "plotSequentialAnalysis";		label: qsTr("Sequential analysis")
			CheckBox { name: "plotSequentialAnalysisRobustness";		label: qsTr("Robustness check") }
		}

		CheckBox
		{
			name: "descriptivesPlots";			label: qsTr("Descriptives")
			CIField { name: "descriptivesPlotsCredibleInterval";	label: qsTr("Credible interval") }
		}
		CheckBox
		{
			name: "descriptivesPlotsRainCloud"; label: qsTr("Raincloud plots")
			CheckBox { name: "descriptivesPlotsRainCloudHorizontalDisplay"; label: qsTr("Horizontal display") }
		}
	}


	RadioButtonGroup
	{
		name: "hypothesis"
		title: qsTr("Alt. Hypothesis")
		RadioButton { value: "notEqualToTestValue";		label: qsTr("≠ Test value"); checked: true		}
		RadioButton { value: "greaterThanTestValue";	label: qsTr("> Test value");					}
		RadioButton { value: "lessThanTestValue";		label: qsTr("< Test value");					}
	}

	BayesFactorType { }

		RadioButtonGroup
	{
		name: "testStatistic"
		id: testStatistic
		title: qsTr("Tests")
		RadioButton
		{
			id: student
			value: "Student";	label: qsTr("Student"); checked: true }
		RadioButton
		{
			value: "Wilcoxon";	label: qsTr("Wilcoxon signed-rank"); id: testWilcoxon
			IntegerField { name: "wilcoxonSamplesNumber"; label: qsTr("No. samples"); defaultValue: 1000; min: 100; max: 10000; fieldWidth: 60 }
		}
	}
	
	Group
	{
		title: qsTr("Additional Statistics")
		CheckBox { name: "descriptives";	label: qsTr("Descriptives") }
	}

	RadioButtonGroup
	{
		name: "missingValues"
		title: qsTr("Missing Values")
		RadioButton { value: "excludeAnalysisByAnalysis";	label: qsTr("Exclude cases per dependent variable"); checked: true	}
		RadioButton { value: "excludeListwise";				label: qsTr("Exclude cases listwise")							}
	}
	

	SubjectivePriors { id: priors }
	
}
