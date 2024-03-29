solution_name    = "Testapp6 - new"
solution_number  = "APM00006"

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
  dialect  = "ANSI"
  virtual  = true
  ha       = true
  role     = "primary"

  availability = "5nines"

  sla {
    availability = "5nines"
    RTO          = "1hr"
    RPO          = "5mins"
  }
}
