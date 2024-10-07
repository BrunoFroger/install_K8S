#!/bin/bash

return $(hostname -I | sed 's/ /\n/g' | grep '192,168,1')