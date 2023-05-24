nslookup metadata-store.tap.tanzu4u.net
curl https://metadata-store.tap.tanzu4u.net/api/health -k -v

kubectl get secret tls -n tanzu-system-ingress -o json | jq -r '.data."tls.crt"' | base64 -d > insight-ca.crt
tanzu insight config set-target https://metadata-store.tap.tanzu4u.net --ca-cert insight-ca.crt
tanzu insight health
#To retrieve the read-only access token, run the following command:
export METADATA_STORE_ACCESS_TOKEN=$(kubectl get secrets metadata-store-read-write-client -n metadata-store -o jsonpath="{.data.token}" | base64 -d)
echo "$METADATA_STORE_ACCESS_TOKEN"