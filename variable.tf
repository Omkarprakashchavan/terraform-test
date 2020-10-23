# variables.tf
variable "profile" {
     default = "omkar-chavan"
}
variable "credentials" {
     default = "C:\\Users\\503162493\\.aws\\credentials"
}
variable "region" {
     default = "us-west-2"
}
variable "availabilityZone" {
     default = "us-west-2a"
}
variable "instanceTenancy" {
    default = "default"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
    default = true
}
variable "vpcCIDRblock" {
    default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {
    default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
    default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "egressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0" ]
}
variable "mapPublicIP" {
    default = true
}
variable "amiid" {
    default = "ami-01fee56b22f308154"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "keyname" {
  default = "terraform"
}
# end of variables.tf
