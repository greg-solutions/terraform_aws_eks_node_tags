module "add_node_name_tag_to_ec2" {
  source = "git::https://github.com/greg-solutions/terraform_aws_k8s_tg_attach.git?ref=v1.0.0"
  region = "us-east-1"
  additional_tags = "Key=Name,Value=Value=node-prefix-$NODE_NAME" // can use special environment variables from k8s like NODE_NAME, POD_NAME, POD_IP, POD_NAMESPACE
}