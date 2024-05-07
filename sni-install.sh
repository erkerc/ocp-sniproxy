sudo -i
podman volume create sniproxy-api-conf
podman volume create sniproxy-apps-conf

podman run -d --name sniproxy-apps -p 443:443/tcp -v sniproxy-apps-conf:/data docker.io/atenart/sniproxy:latest -conf /data/sniproxy.conf
podman run -d --name sniproxy-api -p 6443:6443/tcp -v sniproxy-api-conf:/data docker.io/atenart/sniproxy:latest -bind :6443 -conf /data/sniproxy.conf

podman generate systemd --new --name sniproxy-api -f
podman generate systemd --new --name sniproxy-apps -f

cp *.service /etc/systemd/system

systemctl daemon-reload
systemctl enable container-sniproxy-api.service
systemctl enable container-sniproxy-apps.service
systemctl start container-sniproxy-api.service
systemctl start container-sniproxy-apps.service

cat /var/lib/containers/storage/volumes/sniproxy-api-conf/_data/sniproxy.conf
api.$(CLUSTER_NAME).$(BASE_URL) {
  backend API_URL:6443
}

cat /var/lib/containers/storage/volumes/sniproxy-apps-conf/_data/sniproxy.conf
apps.$(CLUSTER_NAME).$(BASE_URL){
  backend ROUTER_IP:443
  http-redirect http,tls
}