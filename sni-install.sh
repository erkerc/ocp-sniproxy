sudo -i
#podman volume create sniproxy-api-conf
#podman volume create sniproxy-apps-conf

podman run -d --name sniproxy-apps -p 443:443/tcp  --security-opt label=disable -v ./volume-apps/:/data docker.io/atenart/sniproxy:latest --config=/data/sniproxy.conf
podman run -d --name sniproxy-api -p 6443:6443/tcp  --security-opt label=disable -v ./volume-api/:/data docker.io/atenart/sniproxy:latest --config=/data/sniproxy.conf

podman generate systemd --new --name sniproxy-api -f
podman generate systemd --new --name sniproxy-apps -f

cp *.service /etc/systemd/system

systemctl daemon-reload
systemctl enable container-sniproxy-api.service
systemctl enable container-sniproxy-apps.service
systemctl start container-sniproxy-api.service
systemctl start container-sniproxy-apps.service

echo "api.$CLUSTER_NAME.$BASE_URL {
  backend $API_IP:6443
}" > volume-api/sniproxy.conf

cat  volume-api/sniproxy.conf

echo "apps.$CLUSTER_NAME.$BASE_URL{
  backend $ROUTER_IP:443
  http-redirect http,tls
}" > volume-apps/sniproxy.conf

cat volume-apps/sniproxy.conf
