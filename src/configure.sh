#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    echo "Transitioning ($0) to bash and dropping arguments."
    exec /bin/bash $0
    exit
fi

thisDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
scriptsDir="${thisDir}/conf.d"

scripts=$(ls $scriptsDir)
for s in ${scripts[@]}; do
    fullyQualifiedScript="${scriptsDir}/${s}"
    echo "#### EXECUTING ${fullyQualifiedScript} ####"
    /bin/bash $fullyQualifiedScript;
    echo "#### done with ${fullyQualifiedScript} ####"
done
