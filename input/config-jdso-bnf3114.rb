#Config file for Scotus bnf 3114
$confighash = {
	#General Manifest Info
	msslug: "jdso-bnf3114",
	msabbrev: "P",
	manifestLabel: "John Duns Scotus - Ordinatio - Paris, Bibliotheque Nationale de France, ms. lat. 3114",
	manifestDescription: "Witness to Book 4 John Duns Scotus Ordinatio Commentary on the Sentences", 
	seeAlso: "http://gallica.bnf.fr/ark:/12148/btv1b90659708/",
	author: "John Duns Scotus",
	logo: "http://upload.wikimedia.org/wikipedia/fr/thumb/8/84/Logo_BnF.svg/1280px-Logo_BnF.svg.png",
	attribution: "BnF",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1414, 
	canvasHeight: 1054,
	type: "double", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 114, #end number of folios
	side: "", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [33],


	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1414,
	imageHeight: 1054,

	#Image Service Info
	serviceType: "Gallica",
	image_context: "http://iiif.io/api/image/1/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://gallica.bnf.fr/iiif/ark:/12148/btv1b90659708/",
	image_service_count: 5, 
	image_service_skip_array: [7, 22, 23, 62, 65, 67],
	

	#Annotation List Info
	annotationListIdBase: nil

}