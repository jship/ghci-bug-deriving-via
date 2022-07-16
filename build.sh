#!/usr/bin/env bash

find . -type d -maxdepth 1 -not -path '.' | xargs -I _ sh -c 'cd _ && stack build'
