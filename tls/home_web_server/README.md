# Home web server

Objective: Run a HTTPS web server on your workstation and expose it to the public internet.

## Expose HTTP server on public IP address

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

## Add domain name

At your domain name registrar, insert an A record into your zonefile.
In my case, I have purchased the `sebelino.com` domain from Google Domains.
The record should look something like this:

```
web.sebelino.com. 3600 IN A xxx.xxx.xxx.xxx
```

Now try accessing the HTTP web server by the domain name:

```bash
$ curl -s http://web.sebelino.com | grep "Thank you for using nginx"
<p><em>Thank you for using nginx.</em></p>
```

## Untrusted HTTPS

Now let's tell Nginx to server pages over HTTPS. We will use `openssl` to
generate a CA private key + certificate as well as an end-entity private key +
certificate. Nginx will be using the latter pair.

You can populate the `./data/nginx/tls-untrusted/` with this pair of files by
running:

```bash
$ ./make_untrusted_tls.sh
```

Then use `docker-compose` to run Nginx with the directories below
`./data/nginx/` mounted:

```
$ docker-compose -f compose-untrusted-tls.yaml up
```

Now try fetching a page over HTTPS:

```
$ public_ip_address="$(curl -s -4 https://ifconfig.me)"
$ curl https://$public_ip_address --insecure
<html>
<body>
Hello World
</body>
</html>
```

The `--insecure` flag is necessary because `curl` will not recognize the Issuer
of the end-entity certificate as a trusted root certificate.

## Trusted HTTPS

Finally, let's request a certificate issued by a public CA, thus making the
`--insecure` flag unnecessary.

To request a certificate + private key from Let's Encrypt with `certbot`, run:

```
$ ./request_cert.sh
```

Follow the instructions and insert a record into your zonefile as requested.

Rerun the application, this time with the new private key + certificate:

```bash
$ docker-compose -f compose-trusted-tls.yaml up
```
