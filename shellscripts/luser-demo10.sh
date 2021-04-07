#!/bin/bash

log() {
   
       local MESSAGE="${@}"

       if [[ '${VERBOSE}" = 'true']]
       then 
          echo ${MESSAGE}
       fi
}

log 'Heloo'
VERBOSE='true'
log 'This is fun'
