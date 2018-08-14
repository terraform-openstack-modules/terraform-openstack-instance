output "id" {
  value = "${openstack_compute_instance_v2.vm.*.id}"
}

output "name" {
  value = "${openstack_compute_instance_v2.vm.*.name}"
}
