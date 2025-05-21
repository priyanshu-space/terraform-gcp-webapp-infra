resource "google_compute_health_check" "http" {
    name = "http-health-check"
    check_interval_sec = 5
    timeout_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 2

    http_health_check {
        port = 80
        request_path = "/"
    }
}

resource "google_compute_backend_service" "default" {
    name = "web-backend"
    load_balancing_scheme = "EXTERNAL"
    protocol = "HTTP"
    port_name = "http"
    timeout_sec = 10
    health_checks = [google_compute_health_check.http.id]

    backend {
        group = var.instance_group
    }
}

resource "google_compute_url_map" "default" {
    name = "web-url-map"
    default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
    name  = "http-proxy"
    url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "dafault" {
    name = "http-rule"
    target = google_compute_target_http_proxy.dafault.id
    port_range = "80"
    IP_protocol = "TCP"
}