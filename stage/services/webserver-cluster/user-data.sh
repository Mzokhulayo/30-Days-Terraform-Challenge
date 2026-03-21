#!/bin/bash

cat > index.html <<EOF
<h1>Hello World By Mzokhulayo Mdubeki</h1>
<h1>Project: My 30-Days Terraform Learning</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port} 
EOF

nohup python3 -m http.server ${server_port} &