#!/bin/sh

echo "{" > modules.libsonnet

for module in modules/*.libsonnet; do
  name="${module##modules\/}"
  name="${name%%.libsonnet}"
  echo "$name: import '$module'," >> modules.libsonnet
done

echo "}" >> modules.libsonnet
