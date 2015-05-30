#!/usr/bin/env ruby

require 'json'

#params

@msslug = "pp-sorb"
@msabbrev = "S";
@manifestLabel = "Petrus Plaoul - Paris, Bibliotheque Nationale de France, ms. lat. 15897"
@manifestDescription = "Witness of Peter Plaoul's Commentary on the Sentences"

@seeAlso = "http://petrusplaoul.org"
@author = "Petrus Plaoul"
@publishValue = "Paris, circa 1400"

@viewingDirection = "left-to-right"

@numberOfFolios = 227
@canvasWidth = 3184
@canvasHeight = 4112

@imageFormat = "image/jpeg"
@imageWidth = 3184
@imageHeight = 4112

#Create Canvas Array

canvasArray = []
i = 2
count = 5
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
          #{}"@type" => "http://www.shared-canvas.org/ns/context",
          "@id"=> "http://scta.info/iiif/#{@msslug}/annotation/#{@msabbrev}#{fol}-image",
          "@type"=> "oa:Annotation",
          "motivation" => "sc:painting",
          "resource" => {
            "@id" => "http://scta.info/iiif/#{@msslug}/res/#{@msabbrev}#{fol}.jpg",
            "@type"=> "dctypes:Image",
            "format"=> @imageFormat,
            "service"=> {
                "@context"=>"http://iiif.io/api/image/2/context.json",
                "@id"=>"http://gallica.bnf.fr/iiif/ark:/12148/btv1b52000459k/f#{count}",
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

  count += 1

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

