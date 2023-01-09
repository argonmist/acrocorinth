#!/bin/bash

date=$(date '+%Y-%m-%d')
cp -r /var/go/sisyphus/bdd/android/report/ ./
tar zcvf android-bdd-report-$date.tar.gz report
mv android-bdd-report-$date.tar.gz /var/go/bdd-report/android/
