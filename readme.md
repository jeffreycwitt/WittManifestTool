This is a little command line tool I've build to automate my creation of IIIF manifests of medieval manuscripts.

It is customized for my personal project needs, but it could be increasingly generalized. Perhaps its current benefit is just to introduce newcomers to the idea of automated manifest creation and some of the problem areas to be aware of when trying to automatically genereate manifests for manuscripts. 

Please fork and customize if it seems useful. Alternatively, please help make it better and more general and then submit a pull request.

Below is explanation of what problems this script tries to solve and the current method it uses to overcome those problems.

In my case, the basic automation problem is how to correctly declare a lot of canvases correctly aligned with their associated image annotations and image services.

Declaring information for the manifest as a whole is a one time event and doesn't really need to be automated. But most of the manuscripts I'm working with have between 100 and 200 folios. This means I need to create around 400 canvases for each manifest. I've auto created about 30 manifests now, which means about 12,000 canvas entries. I'm not about to type this out by hand. 

In theory this automation is a fairly easy task. I intend for my canvas ids to follow the foliation of the manuscript, and manuscripts are usually numbered in sequential order, so that should just be a simple loop. 

But in practice there are complications. First, a canvas iteration needs to alternate from recto to verso and only change numerical number when moving from verso to recto. Secondly, manuscripts sometime make mistakes and repeat a number or skip a number. We have to be able to account for this.

There are additional difficulties when associating these folios with the corect image on a given image server. The folio number is very often not used as the identifier of the image. Thus, we need to find a way to automatically align the folio number which is used in the canvas id with the service id (or the image file name). Fortunately, Gallica currently uses a sequential numbering to number its images, so, in theory, all we need to do is match up the beginning of the folio sequence with the image file name sequence and everything should line up. But again, in practice, there are problems. Often Gallica's sequence of images includes duplicate images (e.g. f5.jpg and f6.jpg will be separate images of the same folio) and this repetition ruins our alignment. Finally, Gallica images are often images of facing verso and recto pages rather than the preferred image of a single side of a folio.

So, in theory automation is easy. But to make it work, we need a bunch of little extra pieces of information about each manuscript in question so that the canvases will both number correctly (with the right label) and align with the corresponding image id.

The basic idea then is to have configuration file that contains all this idiosyncratic information.

Then we can feed this information into a script that creates the full manifest in a ruby hash.

Finally, we can serialize this hash to json and then save it as a new file. 

Below I've included a sample config file (found in the "input" folder) which includes guided comments. Then I've included the script (with comments) that knows what to do with that config information.

Filename "/input/config-jdso-bnf3155.rb"

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

A couple of notes about this file. Under canvas info you'll see an array called 'folio_skip_array' and 'folio_bis_array.' These arrays tell the loop whether or not a folio number needs to be skipped or a manuscript has numbered two separate folios with the same number. Likewise under canvas info you'll find a key called "type". The value for this (single or double) tells the script whether to make canvases for a single side of a page or for facing verso recto pages.

Second, under "image service info" I've created a service type to tell the creating script to create a service id tailored to the Gallica url system. Because my own image server has a different url scheme, I change the value of this key to "SCTA" when creating a manifest for manuscripts whose images are served from my own server. As I find manuscripts on different IIIF servers, I will create new alternatives in the script for each service type.

You can also see the image_service_skip array which defines those numbers that represent duplicate images in Gallica's numbering scheme. These are images that need to be skipped if the automation is going to be kept in sync.

Finally, while you can see I have set some default values for canvas and image height and width, in practice it is rarely the case that the image sizes are exactly the same. This imprecision causes a problem when trying to associate coordinates to specific parts of the canvas and image. To remedy this problem, the script below will actually make an http request for the info.json file and get the exact height and width dimensions. This significantly slows the script down (as nearly 400 http requests are getting made), but it's worth it to automatically get the exact dimensions.

Below is the class and method definitions that knows how to use this information:
/lib/creator.rb

		require 'json'
		require 'open-uri'
		require 'pry'

		module WittManifestTool
			class Creator

				def initialize (confighash)
					@msslug = confighash[:msslug]
					@msabbrev = confighash[:msabbrev]
					@manifestLabel = confighash[:manifestLabel]
					@manifestDescription = confighash[:manifestDescription]
					@seeAlso = confighash[:seeAlso]
					@author = confighash[:author]
					@logo = confighash[:logo]
					@attribution = confighash[:attribution] 

					@viewingDirection = confighash[:viewingDirection]
					
					@numberOfFolios = confighash[:numberOfFolios]
					@canvasWidth = confighash[:canvasWidth]
					@canvasHeight = confighash[:canvasHeight] 
					@imageFormat = confighash[:imageFormat]
					@imageWidth = confighash[:imageWidth]
					@imageHeight = confighash[:imageHeight]
					@type = confighash[:type]
					@i = confighash[:i]
					@side = confighash[:side]
					@folio_skip_array = confighash[:folio_skip_array]
					@folio_bis_array = confighash[:folio_bis_array]
					
					@presentation_context = confighash[:presentation_context]

					@serviceType = confighash[:serviceType]
					@image_context = confighash[:image_context]
					@image_service_profile = confighash[:image_service_profile]
					@image_service_base = confighash[:image_service_base]
					@image_service_count = confighash[:image_service_count]
					@image_service_skip_array = confighash[:image_service_skip_array] 

					@annotationListIdBase = confighash[:annotationListIdBase]

				end

				def manifest
				manifestHash = {
			    "@context"=>@presentation_context,
			    "@id" => "http://scta.info/iiif/#{@msslug}/manifest",
			    "@type"=>"sc:Manifest",

			    "label"=>@manifestLabel,
			    "metadata"=>
			    [
			      {
			          "label"=>"Author",
			          "value"=> @author
			      },
			      {
			          "label"=>"Published",
			          "value"=> [
			              {
			                  "@language"=> "la"
			              }
			          ]
			      }
			    ],
			    "description"=> @manifestDescription,
			    "license" => "https://creativecommons.org/publicdomain/zero/1.0/",
			    "attribution" => @attribution,
			    "seeAlso" => @seeAlso,
			    "logo" => @logo,
			    "sequences" => self.sequence
			  }
			  puts manifestHash.to_json(pretty: true)
				end
				def sequence
					sequenceHash = [{
			        "@context"=> @presentation_context,
			        "@id"=> "http://scta.info/iiif/#{@msslug}/sequence/normal",
			        "@type"=> "sc:Sequence",
			        "label"=> "Current page order",
			        "viewingDirection" => @viewingDirection,
			        "viewingHint" => "paged",
			        "canvases" => self.canvases
			      }]
			    return sequenceHash
				end
				def canvases
					canvasArray = []
					@already_used_folios = []

					until @i > @numberOfFolios
					  
						## begin a series of checks to see if certain folios or image servide ids need to be skipped

						## first check: has a folio or folios been skipped in the actual numeration of the manuscript. 
						## if true, then skip these folio numbers in the canvaas creation
						while @folio_skip_array.include? @i
							@i += 1
						end
					 	
					 	## second check: does the image service numeration create duplicates that need to be skipped
					 	## if so skip these image ids

					  while @image_service_skip_array.include? @image_service_count
					  	@image_service_count +=1
					  end

					  ## Third Check: check to see if a folio number has been repeated in the actual manuscript foliation and create the foliation 
					  ## this currently varies on whether or not the available images are single pages (which is the ideal)
					  ## or if the images are facing pages.
					  ## if an folio numeration is repeated create the folio label "folio number" + "bis" 
					  ## if the folio is a single page add the side designation (e.g. "r" or "v")

					  if @type == "single"
					    if defined? @folio_bis_array 
					      #checks to see if the verso side of the first instance has already been logged.
					      if @already_used_folios.include? @i
					        fol = @i.to_s + "bis" + @side
					      else
					        fol = @i.to_s + @side
					      end
					    else
					      fol = @i.to_s + @side
					    end
					  elsif @type == "double"
					    if defined? @folio_bis_array # currently on works for verso recto double page image
					      if @already_used_folios.include? @i
					        fol = @i.to_s + "bis"
					      else
					        fol = @i 
					      end
					    else
					      fol = @i  
					    end
					  end 

					  ## Fourth Check: Identify the image service and create service ids specifically designed for each service. 
					  ## New servicesids should be added for each new image-service ui pattern
					  
					  if @serviceType == "Gallica"
					  	serviceid = @image_service_base + "f#{@image_service_count}"
					  elsif @serviceType == "SCTA"
					  	serviceid = @image_service_base + "#{@msslug}/#{@msabbrev}#{fol}.jpg"
					  #add other cases here
					  end
						
						begin
					  	infojson = open(serviceid + "/info.json")
					  rescue OpenURI::HTTPError => ex
		      		infojson = "failure"
		      	end

					  if infojson == "failure"
					  	height = @imageHeight
					  	width = @imageWidth
					  else
							body = JSON.parse(infojson.read)
					  	height = body['height']
					  	width = body['width']
					  end
					  

					  canvas =  {
					      "@context"=>@presentation_context,
					      "@id"=>"http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}",
					      "@type"=>"sc:Canvas",
					      "label"=> "folio #{fol}",
					      #"height"=>@canvasHeight,
					      "height"=>height,
					      #"width"=>@canvasWidth,
					      "width"=>width,
					      "images"=>[
					          {
					          "@context"=>@presentation_context,
					          "@id"=> "http://scta.info/iiif/#{@msslug}/annotation/#{@msabbrev}#{fol}-image",
					          "@type"=> "oa:Annotation",
					          "motivation" => "sc:painting",
					          "resource" => {
					            "@id" => "http://scta.info/iiif/#{@msslug}/res/#{@msabbrev}#{fol}.jpg",
					            "@type"=> "dctypes:Image",
					            "format"=> @imageFormat,
					            "service"=> {
					                "@context"=> @image_context,
					                "@id"=> serviceid,
					                "profile"=> @image_service_profile
					                },
					            #"height"=>@imageHeight,
					            "height"=>height,
					            #"width"=>@imageWidth,
					            "width"=>width,
					          },
					        "on"=> "http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}"
					        }
					      ]
					  }
					  
					  unless @annotationListIdBase == nil
					  	canvas["otherContent"] = [
					  		{
					  			"@id" => "http://scta.info/iiif/#{@msslug}/list/#{@msabbrev}#{fol}",
					  			"@type" => "sc:AnnotationList"
					  		}
					  	]
					  end

					  canvasArray << canvas

					  ## Begin preparation for next iteration.
					  ## if canvases are being created for each side of a leaf, side designation needs to flipped from "r to v" 
					  ## or from "v" to "r" with uptick in the folio counter 
					  ## also needs to account for folio numerations that are repeated and need to be marked as "bis"


					  if @type == "single"
					    if defined? @folio_bis_array 
					      if @folio_bis_array.include? @i
					        @i = @i
					          if @side == "v"
					            @folio_bis_array.delete(@i)
					            @already_used_folios << @i
					          end
					        if fol == "#{@i}r" || fol == "#{@i}bisr"
					          @side = "v"
					        else
					          @side = "r"
					        end
					      else
					        if fol == "#{@i}r" || fol == "#{@i}bisr"
					          @i = @i
					          @side = "v"
					        else
					          @i+=1
					          @side = "r"
					        end
					      end
					    else
					      if fol == "#{@i}r" || fol == "#{@i}bisr"
					        @i = @i
					        @side = "v"
					      else
					        @i+=1
					        @side = "r"
					      end
					    end
					  else
					    if defined? @folio_bis_array 
					      if @folio_bis_array.include? @i
									@i = @i
					        @folio_bis_array.delete(@i)
					        @already_used_folios << @i
					      else
					        @i+=1
					      end    
					    else
					      @i+=1
					    end
					  end

					  @image_service_count += 1

					end
					return canvasArray
				end
			end 
		end



Finally ruby has a nice command line gem that I use to call this function. 

File `/bin/manifest` looks like this:

		#!/usr/bin/env ruby

		require "thor"

		class Manifest < Thor 
			desc "version", "ask for WittManifestTool version"
			def version
				puts "version 0.0.1"
			end
			desc "create manifest INPUT OUTPUT", "create manifest file from data in INPUT file and save in OUTPUT file"
			def create(input)
				require_relative "../lib/creator"
				require_relative "../input/#{input}"
				
				creator = WittManifestTool::Creator.new($confighash)
				creator.manifest
			end
		end

		Manifest.start(ARGV)

Now, in the command line I just run 

    ./bin manifest create config-dsp-bnf14454 > output/dsp-bnf14454.jsonld
