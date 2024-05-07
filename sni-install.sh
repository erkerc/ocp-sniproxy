sudo -i

podman run -d --name sniproxy-api -p 6443:6443/tcp --security-opt label=disable -v /root/ocp-sniproxy/volume-api/:/data docker.io/atenart/sniproxy@sha256:7a24e4cb9aabfe76c353c08eeb069180ece801bec2bf90f5389d6acfe4257f4f -bind :6443 -conf /data/sniproxy.conf

podman run -d --name sniproxy-apps -p 443:443/tcp --security-opt label=disable -v /root/ocp-sniproxy/volume-apps/:/data docker.io/atenart/sniproxy@sha256:7a24e4cb9aabfe76c353c08eeb069180ece801bec2bf90f5389d6acfe4257f4f --config=/data/sniproxy.conf


podman generate systemd --new --name sniproxy-api -f
podman generate systemd --new --name sniproxy-apps -f

cp *.service /etc/systemd/system

systemctl daemon-reload
systemctl enable container-sniproxy-api.service
systemctl enable container-sniproxy-apps.service
systemctl start container-sniproxy-api.service
systemctl start container-sniproxy-apps.service

ss -tlnp