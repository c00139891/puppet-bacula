node yo {

  include role::server

  ssh::allowgroup  { "techops": }
  sudo::allowgroup { "techops": }

  # stahnma needs root to work on some repo things.
  sudo::entry{ "stahnma":
    entry => "stahnma ALL=(ALL) NOPASSWD: ALL\n",
  }

  include service::mrepo

}

