class virtual::ssh_authorized_keys {

  # Key for jenkins slaves to grant access to the jenkins user that's outside
  # of the testing infrastructure
  @ssh_authorized_key {
    "jenkins/hudson@puppetlabs.com":
      user => "jenkins",
      key  => "AAAAB3NzaC1yc2EAAAABIwAAAQEAsMvODgIqL1NoUgP65qmgf0sJjQy78QdA5rHw9tIwK5KstVSh+0w4TLHJq8Jz8E4UeXhx0NioP3kE3otjCC8kSM5y99QOs4qQh7q6cLN9hQpXMQUD9UnJMP0b5agd0PdErH0ML9hnWfsZX707v31VSIbco+X6Kg9wN8WJhlTXgbbrJTUIPnMzNXrN7Z5/jY6Vss7NTCVI7OxUbIna37l5y8s4jxViaXjoVEXP8e4QtTX8p0BYc2vgerI04ZilhbIe4KEcHiR+n/GUr6MmkY5qtLum/7IZLHbHfWha1q7VaPnz/CHmlDySxxq4sF81N4x2V7d0+x8/wNZx2d+duJmV0Q==",
      type => "rsa",
      tag  => "jenkins";
    "jenkins/jetty@enkal.puppetlabs.com":
      user => "jenkins",
      key  => "AAAAB3NzaC1yc2EAAAABIwAAAQEAxPfb1yjRU7E5cQG9+Eq55WWCsLTRmd/tjv/Ym0Sm+3bsoayfKkd7irZEKlyUlgfNx9IkW45E3o8O+LR2+91U4H+Ao6cxLqyXg/5tqLUyyThkS+KBns7HyxC24nnO3h/84mzC1BCO6p3UAwF4gDtYv1LCxshWuwd0dEUTZFTP8E7Xz6dgKnza0745QnRf4xhx3zRwbjW2iJ97bePNZaZf+EgIDPYcjxqUNr69oCfcC0K11oKuqLpu8pmP4rGC/MxqgadGINEJfP+Y14szE/nIjoEJ71IhP9TEDfEAArPMopqed65xOgo/GVFk8Olhi2+xd2JysiVb6dS5BjjFZpBjuw==",
      type => "rsa",
      tag  => "jenkins";
  }

  # Allow motorola access to ssh in with tcp forwarding, but deny all else.
  @ssh_authorized_key { 'motorola_mobillity':
    user    => 'motorola',
    key     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAo/r6KjkRGGR98bTfaNAOExKFJkPTvq2RyTBPEahcm25Lj15KWsT1f4BKUJirlwqe6RerM5DU8h/Nj8WbFJioG09P79oXfJjos801tlSnyEWBxZnHk6ijwKs/R9FVRPp70JMI0BhyC6+3pJfPs71zQdpWQBFaUxTVvZaaazJm8mO0kFBOqWxoWDegf1NxYDmsBL78VAsOYwlI28FrV46LMi/gO8Y0Q1H2qFvE1iJQpeN7fx90/7GiSTsNCBhdUJZsZBSID/WzXRqCFTD5pF0e6Gm6cxz/A3HzsrT6aUgOlfI8nql3AYRG7p8HiCiXKFURCfPVfoIXay1VRo7pLEMxyw==',
    type    => 'ssh-rsa',
    tag     => 'customer',
    options => [
      'no-pty',
      'command="/usr/sbin/nologin"',
      'no-X11-forwarding',
      'no-agent-forwarding',
    ],
  }

  # Grant technical writing ssh access to the documentation deploy user
  @ssh_authorized_key { 'nick@magpie.puppetlabs.lan':
    user => 'deploy',
    key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAy5mtOAMHwA2ZAIfW6Ap70r+I4EclYHEec5xIN59ROUjss23Skb1OtjzYpVPaPH8mSdSmsN0JHaBLiRcu7stl4O8D8zA4mz/vw32yyQ/Kqaxw8l0K76kLXOhKOGqLTY4aFbFISV6GDh7MYLn8KU7cGp96J+caO5R5TqtsStytsUhSyqH+iIDh4e4+BrwTc6V4Y0hgFxaZV5d18mLA4EPYKeG5+zyBCVu+jueYwFqM55E0tHbfiaIN9IzdLV+7NEEfdLkp6w2baLKPqWUBmuvPF1Mn3FwaFLjVsMT3GQeMue6b3FtUdTDeyAYoTxrsRo/WnDkS6Pa3YhrFwjtUqXfdaQ==',
    type => 'ssh-rsa',
    tag  => 'deploy',
  }

  @ssh_authorized_key { 'fred@puppetlabs.com':
    user => 'deploy',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCkgQmrxXEcRSqiKKmtEf4dtPWB3tzP4DD2biuPKt6LtZ8bGnh0O95fFtSoG/WN4mvSwDbjq9MDHY1K0nfz0XSz1tFiB0BPSlwZ4Hf3NvQubAu3FmQFUsv0qlRUd5vAYp/9/XHDy9CKJkS4tCiypgezFDNkG8XE7x2kpNoZ9pIJoxzrFA9uj6JjB1HSAAyIi+QzIpi0o91OTJZEEeST/KAc834cv6Z5ecImFAOgY25CbTLVCA1wesFedr2M4mICoQhfGuO7y5OkdiQASuHIFD3O2tqVOqoG8p+za39mZiyl55m0hNjTGdtXAB+gJ5qztXmM78u+b/lfpViXo3mP39Pd',
    type => 'ssh-rsa',
    tag  => 'deploy',
  }

}
