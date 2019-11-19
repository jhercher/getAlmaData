#!/bin/bash
# Simple script to download bibliographic data of Freie Universität's library interface

helpFunction()
{
   echo ""
   echo "Usage: $0 -c csv-file -f format "
   echo -e "\t-f format to download [ json | bf | bfw | rdf ]"
   echo -e "\t-c csv file with MMSiDs"
   exit 1 # Exit script after printing help
}

while getopts "f:c:" opt
do
   case "$opt" in
      c ) listofids="$OPTARG" ;;
      f ) format="$OPTARG" ;;      
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$format" ] || [ -z "$listofids" ] #|| [ -z "$parameterB" ] 
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

#create directory for the data 
mkdir data

# conditional for the specified format
if [ "$format" == "json" ]
	then
		mkdir data/"$format"-data
		i=1 # to skip the first line of the csv
		while read line
		do
           test $i -eq 1 && ((i=i+1)) && continue # to skip the first line of the csv
    		echo "get $format data for MMSiD: " $line
   	 		curl -0 https://open-na.hosted.exlibrisgroup.com/alma/49KOBV_FUB/bibs/{$line}.jsonld > data/"$format"-data/$line.jsonld
		done < "$listofids" 

elif [ "$format" == "bf" ]
	then 
		mkdir data/"$format"-data
		i=1 # to skip the first line of the csv
		while read line
		do
           test $i -eq 1 && ((i=i+1)) && continue # to skip the first line of the csv
 		   echo "get $format data for MMSiD: " $line
  		   curl -0 https://open-na.hosted.exlibrisgroup.com/alma/49KOBV_FUB/bf/entity/instance/{$line} > data/"$format"-data/$line.xml
		done < "$listofids" 

elif [ "$format" == "bfw" ]
	then 
		mkdir data/"$format"-data
		i=1 # to skip the first line of the csv
		while read line
		do
           test $i -eq 1 && ((i=i+1)) && continue # to skip the first line of the csv

 		   echo "get $format data for MMSiD: " $line
  		   curl -0 https://open-na.hosted.exlibrisgroup.com/alma/49KOBV_FUB/bf/entity/work/{$line} > data/"$format"-data/$line.xml
		done < "$listofids" 

elif [ "$format" == "rdf" ]
	then 
		mkdir data/"$format"-data
		i=1 # to skip the first line of the csv
		while read line
		do
           test $i -eq 1 && ((i=i+1)) && continue # to skip the first line of the csv

 		   echo "get $format data for MMSiD: " $line
  		   curl -0 https://open-na.hosted.exlibrisgroup.com/alma/49KOBV_FUB/rda/entity/manifestation/{$line}.rdf > data/"$format"-data/$line.rdf
		done < "$listofids" 
else
  echo "unknown format"
fi
 