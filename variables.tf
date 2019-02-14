variable "count" {
  type    = "string"
  default = 1
}

variable "hostname" {
  type    = "string"
  default = "hostname"
}

variable "dns" {
  type    = "string"
  default = "guests.privatecloud"
}

variable "network" {
  type    = "string"
  default = "privatenetwork"
}

variable "key_pair" {
  type    = "string"
  default = "key_pair"
}

variable "env" {
  type    = "string"
  default = "staging"
}

variable "flavor" {
  type    = "string"
  default = "large-1"
}

variable "image" {
  type    = "string"
  default = "CentOS-7"
}

variable "secgroup_id" {
  type    = "list"
  default = []
}

variable "fixed_ip_v4" {
  type    = "list"
  default = [""]
}

variable "region" {
  type    = "string"
  default = ""
}

variable "availability_zone" {
  type    = "list"
  default = [""]
}

variable "volume_size" {
  type    = "string"
  default = "30"
}

variable "puppet_server" {
  type    = "string"
  default = "puppet_server"
}

variable "puppet_ip" {
  type    = "string"
  default = "127.0.0.1" 
}
