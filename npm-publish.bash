#!/bin/bash

publish () {
    pushd "$1" && npm publish && popd && clear && ls
}
