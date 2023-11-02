resource "shoreline_notebook" "high_nginx_worker_load_incident" {
  name       = "high_nginx_worker_load_incident"
  data       = file("${path.module}/data/high_nginx_worker_load_incident.json")
  depends_on = [shoreline_action.invoke_worker_connections_optimizer]
}

resource "shoreline_file" "worker_connections_optimizer" {
  name             = "worker_connections_optimizer"
  input_file       = "${path.module}/data/worker_connections_optimizer.sh"
  md5              = filemd5("${path.module}/data/worker_connections_optimizer.sh")
  description      = "Optimize worker connections to balance server load effectively."
  destination_path = "/tmp/worker_connections_optimizer.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_worker_connections_optimizer" {
  name        = "invoke_worker_connections_optimizer"
  description = "Optimize worker connections to balance server load effectively."
  command     = "`chmod +x /tmp/worker_connections_optimizer.sh && /tmp/worker_connections_optimizer.sh`"
  params      = ["PATH_TO_NGINX_CONF","NUMBER_OF_WORKER_CONNECTIONS"]
  file_deps   = ["worker_connections_optimizer"]
  enabled     = true
  depends_on  = [shoreline_file.worker_connections_optimizer]
}

