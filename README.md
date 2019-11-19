# getAlmaData
Shell script to download data (jsonld, bibframe, rdf) from Freie Universität's Library System (ALMA)

 
# Available Formats

- bf (Bibframe instance)
- bfm (Bibframe work)
- json (json LD)
- rdf (RDA descriptions in RDF) 

You need to supply a csv-file with ALMA system numbers (MMSiD).  

# Install

Download and grant writing access for the script.

```
chmod +x getData.sh

```

# Usage

```
./getData.sh -c csv-file_with_MMSiDs.csv -f "[ json | bf | json | rdf ]"
```
# Example 

```
./getData.sh -c MMSiDs.csv -f "json"
```   
