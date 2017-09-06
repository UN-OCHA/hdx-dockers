This document is an extract of data compiled by automated extraction of data from a variety of online sources and manually compiled sources.
The compilation of data is performed on an ongong basis, generally once per day for the automated sources and less frequently for manually compiled sources.
The compilation is done by the Humanitarian Data Exchange (HDX), a project of the UN Office for the Coordination of Humanitarian Affairs.
More information is available at http://docs.hdx.rwlabs.org/

Field Definitions
Source dataset : A unique identifier within HDX for the data source from which the information was obtained.
Indicator ID : A unique identifier within HDX for an indicator.  Indicators are something that can be measured and compared in a time series and applies to a country, crisis, or other entity.  The Indicator ID is provided here to assist those who may be working with the HDX API to extract data from our databases.
Indicator name : A human-readable name for an indicator.  Indicators are something that can be measured and compared in a time series and applies to a country, crisis, or other entity.  
Units : The units of the indicator.
Dataset summary : A summary of how the indicator was compiled by the source.  This field contains information from the data source, and may contain commentary from the HDX team regarding the indicator. 
More info : A source of additional information about the indicator, generally from the organisation from which the indicator was obtained. 
Terms of use : The terms of use from the source of the indicator.  HDX cannot provide interpretation or further information about the terms of use.  Contact the source organization for such questions (see "more info").
HDX methodology : A description of any data processing performed by HDX in compiling the data.  If there is no information in this field, you can assume that the data has been pulled from the source using some form of script, has been validated against acceptable minimum and maxiumum values, and that the units have not changed from the source.  Additional processing will be described here. 



INDICATOR OVERVIEW

Indicator ID : TT011
Indicator name : Total number of estimated deaths due to malaria
Source dataset : WHO Global Health Observatory
Units : Deaths
Data summary : Estimated number of malaria deaths
More info : http://apps.who.int/gho/indicatorregistry/App_Main/view_indicator.aspx?iid=3055
Terms of use : The information in this database is provided as a service to our users. Any use of information in the web site should be accompanied by an acknowledgment of WHO as the source. The responsibility for the interpretation and use of the material lies with the user. In no event shall the World Health Organization be liable for any damages arising from the use of the information linked to this section.
HDX methodology : (i) Countries outside the WHO African Region and low transmission countries in Africa.1 The number of deaths was estimated by multiplying the estimated number of P. falciparum malaria cases by a fixed case fatality rate for each country as described in the World Malaria Report 2008 (16). This method is used for all countries outside the African Region and for countries within the African Region where estimates of case incidence were derived from routine reporting systems and where malaria causes less than 5% of all deaths in children under 5 as described in the Global Burden of Disease 2004 update (19). A case fatality rate (CFR) of 0.45% is applied to the estimated number of P. falciparum cases for countries in the African Region and a CFR of 0.3% for P. falciparum cases in other Regions. In situations where the fraction of all deaths due to malaria is small, the use of a CFR in conjunction with estimates of case incidence was considered to provide a better guide to the levels of malaria mortality than attempts to estimate the fraction of deaths due to malaria.

 
(ii) Other countries in the WHO African Region, and Somalia and Sudan in the Eastern Mediterranean Region. Child malaria deaths were estimated using a verbal autopsy multi-cause model (VAMCM) developed by the WHO Child Health Epidemiology Reference Group (CHERG) to estimate causes of death for children aged 1–59 months in countries with less than 80% of vital registration coverage. The VAMCM is a revised model based on work described elsewhere (20, 21). The VAMCM derives mortality estimates for malaria, as well as 7 other causes (pneumonia, diarrhea, congenital malformation, other neonatal causes, injury, meningitis, and other causes) using multinomial logistic regression methods to ensure that all 9 causes are estimated simultaneously with the total cause fraction summing to 1. The regression model is first constructed using the study-level data and then populated with year 2000–2010 country-level input data to provide time series estimates of causes of death in children aged 1–59 months. Deaths were retrospectively adjusted for coverage of ITNs and use of Haemophilus influenzae type b vaccine. The bootstrap method was employed to estimate uncertainty intervals by re-sampling from the study-level data to estimate the distribution of the predicted percent of deaths due to each cause.
