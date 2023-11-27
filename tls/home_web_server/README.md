# Home web server

Objective: Run a HTTPS web server on your workstation and expose it to the public internet.

Log in to your router. In my case, it is accessible at http://192.168.1.1.

Configure two port-forwarding rules, one for HTTP and one for HTTPS:

* http: Public port = 80, private port = 8080, destination = your private IP address (e.g. `192.168.1.246`)
* https: Public port = 443, private port = 8443, destination = your private IP address

![image](https://github.com/Sebelino/play/assets/837775/c5adb5d0-d965-482e-a60c-432257f64f3b)

If you need to find your private IP address, you can do so with `ifconfig`:

```bash
$ ifconfig | grep "RUNNING" -A1
lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
--
wlp1s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.246  netmask 255.255.255.0  broadcast 192.168.1.255
```

Next, run a simple HTTP Nginx web server:

```bash
$ docker run --rm --name mynginx -p 8080:80 nginx
```

Open a second terminal and confirm that you are able to access the Nginx
application using your public IP address:

```bash
$ public_ip_address="$(curl -s -4 https://ifconfig.me)"
$ curl -s http://$public_ip_address | grep "Welcome to nginx"
<title>Welcome to nginx!</title>
<h1>Welcome to nginx!</h1>
```

Explanation:

1. From your workstation, `curl` sends a HTTP request to your public IP address on port `80`.
1. The router associated with your public IP address forwards the HTTP request to `docker-proxy` running on your workstation on port `8080`.
1. `docker-proxy` forwards the HTTP request to the Nginx application inside the container running on port `80`.
