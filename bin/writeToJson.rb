#!/usr/bin/env ruby

require 'json'

#params

@msslug = "pg-lon"
@msabbrev = "L";
@manifestLabel = "British Royal MS 10 A I"
@manifestDescription = "British Library manuscript of the Sentences Commentary of Peter Gracilis "

@seeAlso = "http://petrusgracilis.lombardpress.org"
@author = "Petrus Gracilis"
@publishValue = "Paris, circa 1370"

@viewingDirection = "left-to-right"

@numberOfFolios = 237
@canvasWidth = 2000
@canvasHeight = 2800

@imageFormat = "image/jpeg"
@imageWidth = 2000
@imageHeight = 2800

#Create Canvas Array

canvasArray = []
i = 1
side = "r"
until i == @numberOfFolios
  fol = i.to_s + side
  canvasArray << {
      "@context"=>"http://iiif.io/api/presentation/2/context.json",
      "@id"=>"http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}",
      "@type"=>"sc:Canvas",
      "label"=> "folio #{fol}",
      "height"=>@canvasHeight,
      "width"=>@canvasWidth,
      "images"=>[
          {
          "@context"=>"http://iiif.io/api/presentation/2/context.json",
          # "@type" => "http://www.shared-canvas.org/ns/context",
          "@id"=> "http://scta.info/iiif/#{@msslug}/annotation/#{@msabbrev}#{fol}-image",
          "@type"=> "oa:Annotation",
          "motivation" => "sc:painting",
          "resource" => {
            "@id" => "http://scta.info/iiif/#{@msslug}/res/#{@msabbrev}#{fol}.jpg",
            "@type"=> "dctypes:Image",
            "format"=> @imageFormat,
            "service"=> {
                "@context"=>"http://iiif.io/api/image/2/context.json",
                "@id"=>"http://images.scta.info:3000/#{@msslug}/#{@msabbrev}#{fol}.jpg",
                "profile"=> "http://iiif.io/api/image/2/level1.json"
                },
            "height"=>@imageHeight,
            "width"=>@imageWidth,
          },
        "on"=> "http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}"
        }
      ]
  }

  if fol == "#{i}r"
    i = i
    side = "v"
  else
    i+=1
    side = "r"
  end

end

#create manifest hash which includes canvas array

manifestHash = {
    "@context"=>"http://iiif.io/api/presentation/2/context.json",
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
                  "@value"=> @publishValue,
                  "@language"=> "la"
              }
          ]
      }
    ],
    "description"=> @manifestDescription,
    "license"=> "Bristish Library Stuff",
    "attribution"=> "British Library Stuff",
    "service"=> "??",
    "seeAlso"=> @seeAlso,
    "within"=> "??",
    "sequences"=>
    [
      {
        "@context"=>"http://iiif.io/api/presentation/2/context.json",
        "@id"=> "http://scta.info/iiif/#{@msslug}/sequence/normal",
        "@type"=> "sc:Sequence",
        "label"=> "Current page order",
        "viewingDirection" => @viewingDirection,
        "viewingHint" => "paged",
        "canvases" => canvasArray
      }
    ]
}



  File.open("#{@msslug}.json","w") do |f|
    f.write(manifestHash.to_json)
  end

