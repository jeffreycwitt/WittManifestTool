#Config file for William de Rothwell Penn mss.
$confighash = {
	#General Manifest Info
	msslug: "wdr-wettf15",
	msabbrev: "A",
	manifestLabel: "William de Rothwell - Aarau, Aargauer Kantonsbibliothek, MsWettF 15",
	manifestDescription: "Witness to William de Rothwell's Commentary on the Sentences", 
	seeAlso: "http://www.e-codices.unifr.ch/en/list/one/kba/WettF0015",
	author: "William de Rothwell",
	logo: "http://e-codices.textandbytes.com/img/logo.png",
	attribution: "e-codices - Virtual Manuscript Library of Switzerland",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1800, 
	canvasHeight: 2192,
	type: "single", # indicates if images are single sides or facing pages.
	i: 107, # starting folio
	numberOfFolios: 175, #end number of folios
	side: "v", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],

	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1800,
	imageHeight: 2192,

	#Image Service Info
	serviceType: "ecodices",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_context: "http://iiif.io/api/image/2/context.json",
	image_service_base: "http://www.e-codices.unifr.ch/loris/kba%2Fkba-WettF0015%2Fkba-WettF0015_",
	image_service_count: 107, # service count number (i.e. starting number for Gallica)
	image_service_skip_array: [],
	
	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/wdr-penn/list/"
}