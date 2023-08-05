
#######From cloud shell

aws ec2 create-key-pair --key-name app --query 'KeyMaterial' --output text > app.pem
                                                  
aws ec2 create-security-group --group-name proxy-sg --description "Security Group for Proxy" --vpc-id vpc-0f1416bebeba8cd41

aws ec2 authorize-security-group-ingress --group-id sg-04b2231871abc0084 --protocol tcp --port 8888 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-04b2231871abc0084 --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 allocate-address --domain vpc
34.232.0.213

#aws ec2 create-nat-gateway --subnet-id subnet-0f21bc9d68a6efa2b --allocation-id eipalloc-09f420f204f62e8a1

#aws ec2 wait nat-gateway-available --nat-gateway-ids nat-0d77b7293e970195a


aws ec2 run-instances --image-id ami-053b0d53c279acc90 --instance-type t2.micro --key-name app --security-group-ids sg-04b2231871abc0084 --subnet-id subnet-0f21bc9d68a6efa2b --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=v2proxy}]'

aws ec2 associate-address --instance-id i-0a481adcc5e6a5f8f --allocation-id eipalloc-09f420f204f62e8a1

aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId, PublicIpAddress]" --output table
34.232.0.213

unlink /etc/resolv.conf
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
sudo ufw disbale

ssh -i "app.pem" ubuntu@ec2-34-232-0-213.compute-1.amazonaws.com

ping google.com
ping 142.250.77.142 80


#######Soxcks5
ssh -i "app.pem"  -D 8888 -f -C -q -N  ubuntu@ec2-34-232-0-213.compute-1.amazonaws.com





