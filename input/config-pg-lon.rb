#Config file for Peter Gracilis London ms
$confighash = {
	#General Manifest Info
	msslug: "pg-lon",
	msabbrev: "L",
	manifestLabel: "Peter Gracilis - British Royal MS 10 A I",
	manifestDescription: "Witness to Peter Gracilis Commentary on the Sentences", 
	seeAlso: "",
	author: "Peter Gracilis",
	logo: "http://upload.wikimedia.org/wikipedia/fr/thumb/8/84/Logo_BnF.svg/1280px-Logo_BnF.svg.png",
	attribution: "British Library",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 2000, 
	canvasHeight: 2800,
	type: "single", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 237, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],

	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 2000,
	imageHeight: 2800,

	#Image Service Info
	serviceType: "SCTA",
	image_service_profile: "http://iiif.io/api/image/1/level2.json", #possibly should be "http://iiif.io/api/image/2/level1.json"
	image_context: "http://iiif.io/api/image/2/context.json",
	image_service_base: "http://images.scta.info:3000/",
	image_service_count: 1, # service count number (i.e. starting number for Gallica)
	image_service_skip_array: [],
	

	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/pg-lon/list/"


	
}