#!/usr/bin/env bash

openssl s_server -accept 8000 -cert rootca.out.crt -key rootca.out.key
