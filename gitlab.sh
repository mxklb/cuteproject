#!/bin/bash
# Install build dependencies for gitlab ci

apt-get update -y
apt-get install -y wget xvfb chrpath libfuse-dev
