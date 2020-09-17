#!/bin/bash
set -ex

yum install wget -y

EC2_INSTANCE_ID="`/usr/bin/wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`"

aws ec2 create-tags --resources $EC2_INSTANCE_ID --region ${region} --tags ${tags}