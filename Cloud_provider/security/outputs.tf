output "bucket_domain" {
  value = "https://${yandex_storage_bucket.bucket.bucket}.website.yandexcloud.net"
}

output "nlb_ip" {
  value = flatten([
    for listener in yandex_lb_network_load_balancer.nlb.listener :
    [for spec in listener.external_address_spec : spec.address]
  ])
}

output "kms_key_id" {
  value = yandex_kms_symmetric_key.bucket_key.id
}

output "instance_group_id" {
  value = yandex_compute_instance_group.ig-lamp.id
}
