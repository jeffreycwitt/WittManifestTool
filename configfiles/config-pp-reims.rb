#Config file for Peter Plaoul Svict mss.
$confighash = {
	#General Manifest Info
	msslug: "pp-reims",
	msabbrev: "R",
	manifestLabel: "Peter Plaoul - Reims",
	manifestDescription: "Witness to Peter Plaoul's Commentary on the Sentences", 
	seeAlso: "",
	author: "Peter Plaoul",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1706, 
	canvasHeight: 2257,
	type: "single", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 214, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],

	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1706,
	imageHeight: 2257,

	#Image Service Info
	serviceType: "SCTA",
	image_context: "http://iiif.io/api/image/2/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://images.scta.info:3000/",
	image_service_count: 1, 
	image_service_skip_array: [],

	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/pp-reims/list/"


	
}