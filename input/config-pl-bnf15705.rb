#Config file for Lombard bnf 15705
$confighash = {
	#General Manifest Info
	msslug: "pl-bnf15705",
	msabbrev: "P",
	manifestLabel: "Peter Lombard - Paris, Bibliotheque Nationale de France, ms. lat. 15705",
	manifestDescription: "Witness to Peter Lombard's Sentences", 
	seeAlso: "http://gallica.bnf.fr/ark:/12148/btv1b10510321r/",
	author: "Peter Lombard",
	logo: "http://upload.wikimedia.org/wikipedia/fr/thumb/8/84/Logo_BnF.svg/1280px-Logo_BnF.svg.png",
	attribution: "BnF",

	#Presentation Context
	presentation_context: "http://iiif.io/api/presentation/2/context.json",
	
	
	# Sequence Info
	viewingDirection: "left-to-right",

	#Canvas Info
	canvasWidth: 1024, 
	canvasHeight: 1493,
	type: "single", # indicates if images are single sides or facing pages.
	i: 3, # starting folio
	numberOfFolios: 161, #end number of folios
	side: "r", #starting folio side
	folio_skip_array: [],
	folio_bis_array: [],


	#Image Info
	imageFormat: "image/jpeg", 
	imageWidth: 1024,
	imageHeight: 1493,

	#Image Service Info
	serviceType: "Gallica",
	image_context: "http://iiif.io/api/image/1/context.json",
	image_service_profile: "http://iiif.io/api/image/1/level2.json",
	image_service_base: "http://gallica.bnf.fr/iiif/ark:/12148/btv1b10510321r/",
	image_service_count: 9, 
	image_service_skip_array: [],
	

	#Annotation List Info
	annotationListIdBase: nil

}
