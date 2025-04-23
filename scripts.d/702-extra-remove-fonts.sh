#!/bin/bash

# Remove Script Fonts
sudo apt purge fonts-{beng*,deva*,gargi,gubbi,gu*,lao,lklug*,lohit*,mlym,nakula,noto-cjk,orya*,pagul,saha*,samyak*,sarai,sil-*,smc-*,taml,telu*,thai*,tlwg*,yrsa*,indic,kacst*,kalapi,knda}  -y

# Update APT Cache
update-fc

echo "Fonts Removed!"
