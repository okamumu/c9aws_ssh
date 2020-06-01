#!/bin/bash

docker build -t okamumu/c9aws . || exit 1
docker push okamumu/c9aws || exit 1

