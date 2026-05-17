locals {
  vm_web_name = "${var.project_name}-${var.environment_name}-${var.vm_web_role}"
  
  vm_db_name = "${var.project_name}-${var.environment_name}-${var.vm_db_role}"
}