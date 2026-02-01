# Quick Optimization Guide

## Network Commands:
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1

## TCP Optimizations:
sudo sysctl -w net.inet.tcp.delayed_ack=0
sudo sysctl -w net.inet.tcp.recvspace=65536
sudo sysctl -w net.inet.tcp.sendspace=65536

## Cleanup Commands:
rm -rf ~/Library/Caches/*
rm -rf ~/.Trash/*
