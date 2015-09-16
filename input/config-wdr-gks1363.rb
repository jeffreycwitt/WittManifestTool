#Config file for William de Rothwell gks1363
$confighash = {
	#General Manifest Info
	msslug: "wdr-gks1363",
	msabbrev: "D",
	manifestLabel: "William de Rothwell - Copenhagen, Danish Royal Library, GKS 1363",
	manifestDescription: "Witness to Book 4 William of Rothwell's commentary on the Sentences of Peter Lombard", 
	seeAlso: "",
	author: "William de Rothwell",
	logo: "https://upload.wikimedia.org/wikipedia/en/4/40/Danish_Royal_Library_Logo1.jpg",
	attribution: "dkb",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1024, 
	canvasHeight: 1496,
	type: "single", # indicates if images are single sides or facing pages.
	i: 1, # starting folio
	numberOfFolios: 49, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],


	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1024,
	imageHeight: 1496,

	#Image Service Info
	serviceType: "dkb",
	image_context: "http://iiif.io/api/image/1/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://kb-images.kb.dk/public/ms/gks1363/1363,4_",
	image_service_count: 1, 
	image_service_skip_array: [],
	

	#Annotation List Info
	annotationListIdBase: "http://scta.info/iiif/wdr-gks1363/list/"

}