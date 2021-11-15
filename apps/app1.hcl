solution_name    = "Testapp1"
solution_number  = "APM00001"

resource "load_balancer" "lb" {
  protocol   = "HTTPS"
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
    database.db, 
    nas.cache 
  ]
}

resource "nas" "cache" {
  type = "netapp"
}

resource "database" "db" {
  type     = "MSSQL"
  platform = "Windows"
  dialect  = "T-SQL"
  arch     = "x86"
  virtual  = true
  ha       = true
  role     = "primary"

  availability = "3nines"

  sla {
    availability = "5nines"
    RTO          = "1hr"
    RPO          = "5mins"
  }
}
