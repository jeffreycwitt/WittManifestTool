#Config file for Durandus of St. Pourcain bnf 14454
$confighash = {
	#General Manifest Info
	msslug: "dsp-bnf14454",
	msabbrev: "P",
	manifestLabel: "Durandus of St. Pourcain - Paris, Bibliotheque Nationale de France, ms. lat. 14563",
	manifestDescription: "Witness to Book 1 of Durandus of St. Pourcain's Commentary on the Sentences", 
	seeAlso: "http://gallicalabs.bnf.fr/ark:/12148/btv1b90660603/",
	author: "Durandus of St. Pourcain",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1024, 
	canvasHeight: 1496,
	type: "single", # indicates if images are single sides or facing pages.
	i: 31, # starting folio
	numberOfFolios: 115, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],


	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1024,
	imageHeight: 1496,

	#Image Service Info
	serviceType: "Gallica",
	image_context: "http://iiif.io/api/image/1/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://gallica.bnf.fr/iiif/ark:/12148/btv1b90660603/",
	image_service_count: 68, 
	image_service_skip_array: [71, 81, 131, 136, 213],
	

	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/dsp-bnf14454/list/"


	
}