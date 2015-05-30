#!/usr/bin/env ruby

require 'json'

#params

@msslug = "rh-bnf15884"
@msabbrev = "P";
@manifestLabel = "Robert Holcot - Paris, Bibliotheque Nationale de France, ms. lat. 15884"
@manifestDescription = "Witness to Robert Holcot's Commentary on the Sentences"

@seeAlso = "?"
@author = "Robert Holcot"
@publishValue = "?"

@viewingDirection = "left-to-right"

@numberOfFolios = 95
@canvasWidth = 1028
@canvasHeight = 708

@imageFormat = "image/jpeg"
@imageWidth = 1028
@imageHeight = 708

#Create Canvas Array

canvasArray = []
i = 1
count = 1

until i == @numberOfFolios
  fol = i
  if count == 23
    count += 1
  end
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
                "@context"=>"http://iiif.io/api/image/1/context.json",
                "@id"=>"http://gallica.bnf.fr/iiif/ark:/12148/btv1b9076796d/f#{count}",
                "profile"=> "http://iiif.io/api/image/1/level2.json"
                },
            "height"=>@imageHeight,
            "width"=>@imageWidth,
          },
        "on"=> "http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}"
        }
      ]
  }

  
  i+=1

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
    "license"=> "BnF",
    "attribution"=> "BnF",
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

