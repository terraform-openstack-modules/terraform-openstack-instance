output "instance_id" {
  value = "${openstack_compute_instance_v2.vm.*.id}"
}

output "instance_name" {
  value = "${openstack_compute_instance_v2.vm.*.name}"
}
