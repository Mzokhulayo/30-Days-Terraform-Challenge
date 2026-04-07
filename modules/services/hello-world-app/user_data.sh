#!/bin/bash

cat > index.html <<EOF
<h1>${server_text}</h1>
<h1> for Blue/Green Deployment</h1>
EOF


nohup python3 -m http.server ${server_port} &