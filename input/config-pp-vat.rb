#Config file for Peter Plaoul Vat mss.
$confighash = {
	#General Manifest Info
	msslug: "pp-vat",
	msabbrev: "V",
	manifestLabel: "Peter Plaoul - Vatican",
	manifestDescription: "Witness to Peter Plaoul's Commentary on the Sentences", 
	seeAlso: "",
	author: "Peter Plaoul",
	logo: "http://upload.wikimedia.org/wikipedia/fr/thumb/8/84/Logo_BnF.svg/1280px-Logo_BnF.svg.png",
	attribution: "Vaticana",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1800, 
	canvasHeight: 2192,
	type: "single", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 192, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],

	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1800,
	imageHeight: 2192,

	#Image Service Info
	serviceType: "SCTA",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_context: "http://iiif.io/api/image/2/context.json",
	image_service_base: "http://images.scta.info:3000/",
	image_service_count: 1, # service count number (i.e. starting number for Gallica)
	image_service_skip_array: [],
	

	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/pp-vat/list/"


	
}