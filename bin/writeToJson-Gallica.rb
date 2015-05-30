#!/usr/bin/env ruby

require 'json'


require_relative 'config-rfr-bnf15853'

#Create Canvas Array

canvasArray = []
@already_used_folios = []

until @i > @numberOfFolios
  #fol = @i

  if @folio_skip_array.include? @i
      @i +=1
      ## this should deal with back to back skips similiar to below but handled in a different perhaps better way
      if @folio_skip_array.include? @i 
        @i +=1
      end
  end
 
  if @gallica_skip_array.include? @count
    #this conditional is needed to handle back to back skips. Will need to be improved if have three skips back to back 
    skiphash = Hash[@gallica_skip_array.each_index.zip(@gallica_skip_array)].invert
    if @gallica_skip_array[skiphash[@count] + 1] == @count + 1 ## should skip two Gallica pages if two files in a row need to be skipped
      @count += 2
    else
      @count += 1
    end
  end

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
                "@id"=>"http://gallica.bnf.fr/iiif/ark:/12148/#{@gallicaID}/f#{@count}",
                "profile"=> "http://iiif.io/api/image/1/level2.json"
                },
            "height"=>@imageHeight,
            "width"=>@imageWidth,
          },
        "on"=> "http://scta.info/iiif/#{@msslug}/canvas/#{@msabbrev}#{fol}"
        }
      ]
  }

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
    puts @already_used_folios.inspect
  else
    if defined? @folio_bis_array # currently on works for verso recto double page image
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

  @count += 1

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
                  "@language"=> "la"
              }
          ]
      }
    ],
    "description"=> @manifestDescription,
    "license": "https://creativecommons.org/publicdomain/zero/1.0/",
    "attribution"=> "BnF",
    "service"=> "??",
    "seeAlso"=> @seeAlso,
    "within"=> "??",
    "logo": "https://raw.githubusercontent.com/IIIF/m2/master/images/logos/bnf-logo.jpeg",
    "related": "http://gallica.bnf.fr/ark:/12148/#{@gallicaID}",
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

