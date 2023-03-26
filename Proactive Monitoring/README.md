# Proactive Monitoring

Scripts that regularly send "heartbeats" and status information to a central server.

Central server can then determine if a server is offline if it hasn't heard a heartbeat within a set amount of time.

```
Reporting/ - Central server code that all servers/clients report to.
Servers/ - Site servers - heartbeats sent to an external server every x minutes
Clients/ - Regular user machines
```
