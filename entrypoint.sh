#!/bin/bash
service apache2 start
tail -f /var/log/apache2/mod_jk.log
