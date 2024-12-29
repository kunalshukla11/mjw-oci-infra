locals {
  protocol_number = {
    icmp   = 1
    icmpv6 = 58
    tcp    = 6
    udp    = 17
  }

  instance = {
    db_ubuntu = {
      shape : "VM.Standard.A1.Flex",
      operating_system = "Canonical Ubuntu",
      user_data : {
        runcmd : ["apt-get remove --quiet --assume-yes --purge apparmor"],
      },
    },
  }
}
