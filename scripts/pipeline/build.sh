#!/bin/bash
mv yamls $HOME/triangle/gitbook/
cd $HOME/triangle/gitbook/
bash book.sh $server_ip 
bash gitbook_build.sh
bash nginx.sh
rm -rf yamls
