packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}

variable "version" {
  type    = string
  default = ""
}

source "vmware-iso" "ubuntu" {
  boot_command     = ["<wait>c<wait>set gfxpayload=keep<enter><wait>linux /casper/vmlinuz quiet autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/ ---<enter><wait>initrd /casper/initrd<wait><enter><wait>boot<enter><wait>"]
  boot_wait        = "10s"
  cpus             = 2
  disk_size        = 20480
  guest_os_type    = "ubuntu-64"
  headless         = true
  http_directory   = "http"
  iso_checksum     = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_urls         = ["https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso?_ga=2.78981842.712538541.1701271816-1792201907.1701271816"]
  memory           = 2048
  shutdown_command = "echo '12345678'|sudo -S shutdown -P now"
  ssh_password     = "12345678"
  ssh_port         = 22
  ssh_username     = "user"
  ssh_wait_timeout = "10000s"
  vm_name          = "packer-ubuntu-22.04-amd64"
}

build {
  sources = ["source.vmware-iso.ubuntu"]

}
