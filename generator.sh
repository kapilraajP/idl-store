. configuration.config
for d in */ ; do
    [ -L "${d%/}" ] && continue
    echo "$d"
    file=$d"openapi.yaml"
    file1=$d"openapi.yml"
    file2=$d"Ballerina.toml"
    file3=$d"Ballerina.toml"
    echo $DESTINATIONFILE
    if [ -f "$file" ]
    then
        echo "$0: File '${file}' found."
        # cat ${file}
        # yq e '.info.version | to_entries | map(.value) | .[]' ${file}
        yq '.info.version' ${file}
        { read -r var3; } < <(yq '.servers[].url' ${file})
        if [ ! -d $DESTINATIONFILE$d ]; then
            id=$(awk -F "=" '/name/ {print $2}' $file2 | tr -d ' ')
            keywords=$(awk -F "=" '/keywords/ {print $2}' $file2 | tr -d ' ')
            mkdir -p $DESTINATIONFILE$d;
            { read -r var1; } < <(yq '.info.version' ${file})
            declare -p var1
            { read -r var2; } < <(yq '.info.x-ballerina-display.label' ${file})
            declare -p var2
            { read -r description; } < <(yq '.info.description' ${file})
            declare -p description
            echo "$description"
            editedDescription="${description/This is a generated connector for/"This is the"}"  
            { read -r initdescription; } < <(yq '.info.x-ballerina-init-description' ${file})
            declare -p initdescription
            editedInitDescription="${initdescription/The connector initialization requires setting the API credentials./""}"
            mkdir -p $DESTINATIONFILE$d/$var1;
            cp $d/icon.png $DESTINATIONFILE$d/$var1;
            cp $d/openapi.yaml $DESTINATIONFILE$d/$var1;
            echo '## Overview' > $DESTINATIONFILE$d/$var1/readme.md
            echo "" >> $DESTINATIONFILE$d/$var1/readme.md
            echo "$editedDescription" >> $DESTINATIONFILE$d/$var1/readme.md
            echo '## Prerequisites' >> $DESTINATIONFILE$d/$var1/readme.md
            echo "" >> $DESTINATIONFILE$d/$var1/readme.md
            echo "$editedInitDescription" >> $DESTINATIONFILE$d/$var1/readme.md
            echo "$d"
            yq e  -n '
            .id = '$id' |
            .type = "OpenAPI" |
            .version = "'$var1'" |
            .description = "'$var1'" |
            .idlPath = "'/$d$var1/openapi.yaml'" |
            .thumbnailPath = "'/$d$var1/icon.png'" |
            .documentationPath = "'/$d$var1/readme.md'" |
            .keywords = '$keywords > $DESTINATIONFILE$d$var1/metadata.yaml
            { read -r var3; } < <(yq '.servers[].url' ${file})
            declare -p var3
            echo "$var3"
            { read -r endpointdescription; } < <(yq '.servers[].description' ${file})
            declare -p endpointdescription
            echo "$endpointdescription"
            if [ -z "$var2" ]
            then
                echo "\$var2 is empty"
            else
                echo "\$var2 is not empty"
            fi
            if [ -z "$var3" ]
            then
                echo "\$var3 is empty"
            else
                # if [ -z "$endpointdescription" ]
                # then
                #     yq e '.endpoint += [{"url": "'$var3'"}]' -i $DESTINATIONFILE$d$var1/metadata.yaml
                # else
                #     yq e '.endpoint += [{"description": "'$endpointdescription'", "url": "'$var3'"}]' -i $DESTINATIONFILE$d$var1/metadata.yaml
                # fi
                yq e '.endpoint += [{"url": "'$var3'"}]' -i $DESTINATIONFILE$d$var1/metadata.yaml
                # yq e '.endpoint.description = "'$endpointdescription'"' -i $DESTINATIONFILE$d$var1/metadata.yaml
            fi
        fi
    fi
    if [ -f "$file1" ]
    then
        echo "$0: File '${file1}' found."
        { read -r var4; } < <(yq '.servers[].url' ${file1})
        echo "$var4"
        if [ ! -d $DESTINATIONFILE$d ]; then
            id=$(awk -F "=" '/name/ {print $2}' $file3 | tr -d ' ')
            echo "$id"
            keywords=$(awk -F "=" '/keywords/ {print $2}' $file3 | tr -d ' ')
            echo "$keywords"
            mkdir -p $DESTINATIONFILE$d;
            { read -r var5; } < <(yq '.info.version' ${file1})
            declare -p var5
            echo "$var5"
            { read -r var6; } < <(yq '.info.x-ballerina-display.label' ${file1})
            declare -p var6
            echo "$var6"
            { read -r description1; } < <(yq '.info.description' ${file1})
            declare -p description1
            echo "$description1"
            editedDescription1="${description1/This is a generated connector for/"This is the"}"  
            { read -r initdescription1; } < <(yq '.info.x-ballerina-init-description' ${file1})
            declare -p initdescription1
            editedInitDescription1="${initdescription1/The connector initialization requires setting the API credentials./""}"
            mkdir -p $DESTINATIONFILE$d/$var5;
            cp $d/icon.png $DESTINATIONFILE$d/$var5;
            cp $d/openapi.yml $DESTINATIONFILE$d/$var5;
            echo '## Overview' > $DESTINATIONFILE$d/$var5/readme.md
            echo "" >> $DESTINATIONFILE$d/$var1/readme.md
            echo "$editedDescription1" >> $DESTINATIONFILE$d/$var5/readme.md
            echo '## Prerequisites' >> $DESTINATIONFILE$d/$var5/readme.md
            echo "" >> $DESTINATIONFILE$d/$var5/readme.md
            echo "$editedInitDescription1" >> $DESTINATIONFILE$d/$var5/readme.md
            echo $DESTINATIONFILE$d$var5/metadata.yaml
            echo "$d"
            yq e  -n '
            .id = '$id' |
            .type = "OpenAPI" |
            .version = "'$var5'" |
            .description = "'$var5'" |
            .idlPath = "'/$d$var5/openapi.yaml'" |
            .thumbnailPath = "'/$d$var5/icon.png'" |
            .documentationPath = "'/$d$var5/readme.md'" |
            .keywords = '$keywords > $DESTINATIONFILE$d$var5/metadata.yaml
            { read -r endpointdescription; } < <(yq '.servers[].description' ${file1})
            declare -p endpointdescription
            echo "$endpointdescription"
            if [ -z "$var4" ]
            then
                echo "\$var4 is empty"
            else
                yq e '.endpoint += [{"url": "'$var4'"}]' -i $DESTINATIONFILE$d$var5/metadata.yaml
                # yq e '.endpoint.description = "'$endpointdescription'"' -i $DESTINATIONFILE$d$var5/metadata.yaml
            fi
        fi
    fi
done