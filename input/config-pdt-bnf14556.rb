#Config file for Scotus bnf 3114
$confighash = {
	#General Manifest Info
	msslug: "pdt-bnf14556",
	msabbrev: "P",
	manifestLabel: "Peter of Tarantasia - Paris, Bibliotheque Nationale de France, ms. lat. 14556",
	manifestDescription: "Witness to Book 1 and 2 of Peter of Tarantasia's Commentary on the Sentences", 
	seeAlso: "http://gallicalabs.bnf.fr/ark:/12148/btv1b9066640d/",
	author: "Petrus de Tarantasia",
	logo: "http://upload.wikimedia.org/wikipedia/fr/thumb/8/84/Logo_BnF.svg/1280px-Logo_BnF.svg.png",
	attribution: "BnF",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1024, 
	canvasHeight: 1528,
	type: "single", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 163, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],


	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1024,
	imageHeight: 1024,

	#Image Service Info
	serviceType: "Gallica",
	image_context: "http://iiif.io/api/image/1/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://gallica.bnf.fr/iiif/ark:/12148/btv1b9066640d/",
	image_service_count: 5, 
	image_service_skip_array: [153, 161, 180, 181, 244, 245, 258],
	

	#Annotation List Info
	annotationListIdBase: nil

}