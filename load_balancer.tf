## This configuration was generated by terraform-provider-oci

resource oci_load_balancer_load_balancer web_lb2 {
  compartment_id = var.compartment_ocid
  defined_tags = {}
  display_name = "web_lb"
  freeform_tags = {
  }
  ip_mode    = "IPV4"
  is_private = "false"
  network_security_group_ids = [
  ]
  #reserved_ips = <<Optional>>
  shape = "flexible"
  shape_details {
    maximum_bandwidth_in_mbps = "10"
    minimum_bandwidth_in_mbps = "10"
  }
  subnet_ids = [
    oci_core_subnet.Public-Subnet-demo_vcn.id,
  ]
}

resource oci_load_balancer_backend_set backend_web_demo {
  health_checker {
    interval_ms         = "10000"
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ""
    retries             = "3"
    return_code         = "200"
    timeout_in_millis   = "3000"
    url_path            = "/"
  }
  load_balancer_id = oci_load_balancer_load_balancer.web_lb2.id
  name             = "backend_web_demo"
  policy           = "ROUND_ROBIN"
}

resource oci_load_balancer_backend export_10-1-1-79-80 {
  backendset_name  = oci_load_balancer_backend_set.backend_web_demo.name
  backup           = "false"
  drain            = "false"
  ip_address       = "10.1.1.79"
  load_balancer_id = oci_load_balancer_load_balancer.web_lb2.id
  offline          = "false"
  port             = "80"
  weight           = "1"
}

resource oci_load_balancer_backend export_10-1-1-32-80 {
  backendset_name  = oci_load_balancer_backend_set.backend_web_demo.name
  backup           = "false"
  drain            = "false"
  ip_address       = "10.1.1.32"
  load_balancer_id = oci_load_balancer_load_balancer.web_lb2.id
  offline          = "false"
  port             = "80"
  weight           = "1"
}

resource oci_load_balancer_listener web_lb2_listener_lb_web {
  connection_configuration {
    backend_tcp_proxy_protocol_version = "0"
    idle_timeout_in_seconds            = "60"
  }
  default_backend_set_name = oci_load_balancer_backend_set.backend_web_demo.name
  hostname_names = [
  ]
  load_balancer_id = oci_load_balancer_load_balancer.web_lb2.id
  name             = "listener_lb_web"
  #path_route_set_name = <<Optional>>
  port     = "80"
  protocol = "HTTP"
  #routing_policy_name = <<Optional>>
  rule_set_names = [
  ]
}

