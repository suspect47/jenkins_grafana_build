#!/bin/bash
WORKDIR=/home/jenkins/workspace/ultima-common/linux-amd64/ultima-grafana/ultima-grafana

if ! [ -z $PLUGIN1 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN1"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN2 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN2"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN3 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN3"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN4 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN4"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN5 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN5"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN6 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN6"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN7 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN7"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN8 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN8"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN9 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN9"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
if ! [ -z $PLUGIN10 ] ; then echo "docker exec grafana grafana-cli plugins install "$PLUGIN10"" | tee -a /$WORKDIR/neyross-grafana.sh; fi
echo "echo 'apiVersion: 1

datasources:
  - name: Influxdb
    type: influxdb
    url: http://influxdb:8086
    database: telegraf
    user: user
    password: 123456' > /opt/monitoring/datasource.yml" >> $WORKDIR/neyross-grafana.sh

echo 'docker cp /opt/monitoring/datasource.yml grafana:/etc/grafana/provisioning/datasources/datasource.yml
rm -f /opt/monitoring/datasource.yml
docker exec grafana grafana-cli admin reset-admin-password 123456
docker container restart grafana
exit 0' >> $WORKDIR/neyross-grafana.sh

MAX_STRINGS=$(wc -l $WORKDIR/neyross-grafana.sh | awk '{print $1}')
LAST_STRING=$(($MAX_STRINGS + 1))

sed -i -e "s/LAST_STRING/+$LAST_STRING/g" $WORKDIR/neyross-grafana.sh

cd $WORKDIR && tar czvf docker-compose.yml.tar.gz docker-compose.yml

cat $WORKDIR/docker-compose.yml.tar.gz >> $WORKDIR/neyross-grafana.sh
