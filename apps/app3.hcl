solution_name    = "Testapp3"
solution_number  = "APM00003"

resource "load_balancer" "lb" {
  protocol = "HTTPS"
  depends_on = [ server.ui ] 
}

resource "server" "ui" {
  os         = "Windows"
  virtual    = true
  hypervisor = "vmware"
  arch       = "x86"
  cores      = 2
  memory     = 8
  role       = "active"
  count      = 2

  depends_on = [ 
    database.db
  ]
}

resource "database" "db" {
  type     = "MSSQL"
  platform = "Windows"
  arch     = "x86"
  virtual  = true
  ha       = true
  role     = "primary"

  sla {
    availability = "5nines"
    RTO          = "1hr"
    RPO          = "5mins"
  }
}
