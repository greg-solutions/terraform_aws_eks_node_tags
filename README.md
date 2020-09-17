### Terraform module for add new tags to EC2 instances which uses as worker nodes in k8s cluster

#### Node must have policy ""ec2:CreateTags""

You can add any tags what you want as string. Example:
"Key=Name,Value=Value=node-prefix-$NODE_NAME Key=test_key_2,Value=test_value_2 Key=ConsistPod,Value=Nginx"