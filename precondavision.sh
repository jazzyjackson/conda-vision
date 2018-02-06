#!/bin/bash
pythonversion=$1            # and use first argument as python script
condamods=$"${@:2}"           # any remaining arguments will be passed to conda

sortedmods=$(echo $condamods | tr " " "\n" | sort -u)
condahash=$(echo $pythonversion$sortedmods | openssl md5 | tr -cd [:alnum:] )

echo $condahash
echo $pythonversion
echo $condamods

conda create --yes --name $condahash --quiet $pythonversion $(echo $sortedmods)
