
if [ -z $CLUSTER_NAME ]
then
    echo -e "\e[91mEnvironment variable CLUSTER_NAME not specified (labk8s).\e[39m"
    exit 1
fi

if [ -z $CLUSTER_DOMAIN ]
then
    echo -e "\e[91mEnvironment variable CLUSTER_DOMAIN not specified (mydance.zone).\e[39m"
    exit 1
fi

if [ -z $AWS_BUCKETURI ]
then
    echo -e "\e[91mEnvironment variable AWS_BUCKETURI not specified (s3://mydance-kops).\e[39m"
    exit 1
fi

if [ -z $AWS_ACCESSKEY ] || [ -z $AWS_SECRETACCESSKEY ] || [ -z $AWS_ZONE ]
then
    echo -e "\e[91mEnvironment variables AWS_ACCESSKEY, AWS_SECRETACCESSKEY or AWS_REGION not specified.\e[39m"
else
    echo -e "\e[94mAWS login...\e[39m"
    aws configure set aws_access_key_id $AWS_ACCESSKEY
    aws configure set aws_secret_access_key $AWS_SECRETACCESSKEY
    aws iam get-user
    echo -e "\e[92mDone\e[39m"
    echo ""
fi

volume_size=10
masters_count=1
workers_count=3
masters_size="t3a.large"
workers_size="t3a.medium"
name=$CLUSTER_NAME.$CLUSTER_DOMAIN

echo -e "\e[94mCreate cluster initial config...\e[39m"
kops create cluster \
    --name=$name \
    --state=$AWS_BUCKETURI \
    --dns-zone=$CLUSTER_DOMAIN \
    --out=. \
    --zones=$AWS_ZONE \
    --master-count $masters_count \
    --node-count $workers_count \
    --topology public \
    --master-size $masters_size \
    --node-size $workers_size \
    --networking=calico \
    --node-volume-size $volume_size \
    --master-volume-size $volume_size \
    --container-runtime containerd
echo -e "\e[92mDone\e[39m"
echo ""

echo -e "\e[94mEdit cluster config...\e[39m"
aws s3 cp "$AWS_BUCKETURI/$name/config" "./tmp/config"
yaml_cli -i ./tmp/config -o ./tmp/config \
    -b spec:metricsServer:enabled true \
    -b spec:metricsServer:insecure true \
    -b spec:clusterAutoscaler:enabled true \
    -b spec:clusterAutoscaler:skipNodesWithLocalStorage true \
    -b spec:clusterAutoscaler:skipNodesWithSystemPods true \
    -l spec:kubeAPIServer:apiAudiences api istio-ca \
    -s spec:kubeAPIServer:serviceAccountIssuer 'kubernetes.default.svc'
echo "./tmp/config edited"
aws s3 cp "./tmp/config" "$AWS_BUCKETURI/$name/config"
echo -e "\e[92mDone\e[39m"
echo ""

echo -e "\e[94mEdit workers config...\e[39m"
aws s3 cp "$AWS_BUCKETURI/$name/instancegroup/nodes-$AWS_ZONE" "./tmp/nodes-$AWS_ZONE"
yaml_cli -i "./tmp/nodes-$AWS_ZONE" -o "./tmp/nodes-$AWS_ZONE" \
    -s spec:maxPrice "0.03" \
    -s spec:rootVolumeType "gp2" \
    -n spec:maxSize 15 \
    -n spec:minSize 3
echo "./tmp/nodes-$AWS_ZONE edited"
aws s3 cp "./tmp/nodes-$AWS_ZONE" "$AWS_BUCKETURI/$name/instancegroup/nodes-$AWS_ZONE"
echo -e "\e[92mDone\e[39m"
echo ""

echo -e "\e[94mEdit masters config...\e[39m"
aws s3 cp "$AWS_BUCKETURI/$name/instancegroup/master-$AWS_ZONE" "./tmp/master-$AWS_ZONE"
yaml_cli -i "./tmp/master-$AWS_ZONE" -o "./tmp/master-$AWS_ZONE" \
    -s spec:maxPrice "0.03" \
    -s spec:rootVolumeType "gp2"
echo "./tmp/master-$AWS_ZONE edited"
aws s3 cp "./tmp/master-$AWS_ZONE" "$AWS_BUCKETURI/$name/instancegroup/master-$AWS_ZONE"
echo -e "\e[92mDone\e[39m"
echo ""

echo -e "\e[94mUpdate cluster...\e[39m"
kops update cluster --name $name --yes --admin --state=$AWS_BUCKETURI
echo -e "\e[92mDone\e[39m"
echo ""

echo ""
echo -e "\e[94mK8s endpoint on https://api.$name\e[39m"
echo ""
echo -e "\e[94m$masters_count x masters ($masters_size:$volume_size Gb)\e[39m"
echo -e "\e[94m$workers_count x workers ($workers_size:$volume_size Gb)\e[39m"
echo ""
echo -e "\e[94mmetricsServer:enabled\e[39m"
echo -e "\e[94mclusterAutoscaler:enabled\e[39m"
echo ""

echo -e "\e[93mView creation progress: kops validate cluster --wait 10m --state=$AWS_BUCKETURI\e[39m"
echo -e "\e[93mConfigure cluster context: kops export kubecfg --admin --state=$AWS_BUCKETURI --name=$name\e[39m"
echo -e "\e[93mEdit cluster specs: kops edit cluster $name\e[39m"
echo -e "\e[93mEdit worker specs: kops edit ig --name=$name nodes-$AWS_ZONE\e[39m"
echo -e "\e[93mEdit master specs: kops edit ig --name=$name master-$AWS_ZONE\e[39m"
echo -e "\e[93mDelete this cluster: kops delete cluster --name=$name --state=$AWS_BUCKETURI --yes\e[39m"
echo ""