#!/bin/bash
echo 'export PATH="$PATH:/usr/local/apache2/bin"' >> ~/.bashrc
apachectl -DFOREGROUND