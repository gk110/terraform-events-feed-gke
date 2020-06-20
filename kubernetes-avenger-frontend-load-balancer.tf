resource "kubernetes_service" "avenger-frontend-services" {
  metadata {
    name      = "avenger-frontend-services"
    namespace = kubernetes_namespace.events_ns.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.avenger-frontend-services.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.avenger-frontend-services.load_balancer_ingress[0].ip
}