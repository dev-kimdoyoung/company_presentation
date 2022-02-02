output "ip" {
    value = "${aws_instance.my_ec2_node.public_ip}"
}