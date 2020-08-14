# **Immutable Web Server Application Load Balancer**

Creates an immutable two web server ec2 instances with one application load balancer.

## **Author**

Jorge Alvarez <alvarez.jeap@gmail.com>

## **Requirements**

- [Terraform](https://www.terraform.io/) 0.12+
- [Ansible](https://docs.ansible.com/) 2.9+
- AWS Account
  - Access and secret keys

## **Playground**

- Create

```sh
terraform apply --auto-approve \
    -var "ssh_private_key_path=${SSH_PRIVATE_KEY_PATH}" \
    -var "aws_access_key=${AWS_ACCESS_KEY}" \
    -var "aws_secret_key=${AWS_SECRET_KEY}"
```

- Destroy

```sh
terraform destroy --auto-approve \
    -var "ssh_private_key_path=${SSH_PRIVATE_KEY_PATH}" \
    -var "aws_access_key=${AWS_ACCESS_KEY}" \
    -var "aws_secret_key=${AWS_SECRET_KEY}"
```
