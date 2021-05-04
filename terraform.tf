provider "vsphere" {
  user           = "admin"
  password       = "Iwiiap@13ns"
  vsphere_server = "10.241.110.12"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "dc1"
}

data "vsphere_datastore" "datastore" {
  name          = "dc1_datastore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "dc1/testvm/myguestvm1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "public"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 4 GB
  memory   = 8 GB
  guest_id = "other3xLinux64Guest"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    label = "disk0"
    size  = "120 GB"
  }
}


resource "azurerm_postgresql_server" {
  host            = "10.241.110.12"
  port            = 5432
  database        = "test_db"
  username        = "user1"
  password        = "Slkcpal@35"
  sslmode         = "not require"

}
