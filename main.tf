resource "openstack_compute_instance_v2" "vm" {
  count             = "${var.count}"
  name              = "${var.hostname}${format("%02d", count.index+1)}.${var.dns}"
  region            = "${var.region}"
  availability_zone = "${element(var.availability_zone,count.index)}"
  flavor_name       = "${var.flavor}"
  image_name        = "${var.image}"
  key_pair          = "${var.key_pair}"
  network           = {
    name            = "${var.network}"
    fixed_ip_v4     = "${element(var.fixed_ip_v4,count.index)}"
  }
  security_groups   = [ 
                      "${var.secgroup_id}" 
                      ]
  user_data         = "${element(data.template_file.puppet-userdata.*.rendered,count.index)}"

  block_device {
    uuid                  = "${data.openstack_images_image_v2.image.id}"
    source_type           = "image"
    volume_size           = "${var.volume_size}"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

}


data "openstack_images_image_v2" "image" {
  name = "${var.image}"
  most_recent = true

  properties = {
    key = "value"
  }
}


data "template_file" "puppet-userdata" {
  count           = "${var.count}"
  template        = "${file("${path.module}/templates/userdata.tpl")}"
  vars {
    hostname      = "${var.hostname}${format("%02d", count.index+1)}.${var.dns}" 
    env           = "${var.env}"
    puppet_server = "${var.puppet_server}"
    puppet_ip     = "${var.puppet_ip}"
  }
}
