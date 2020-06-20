resource "kubernetes_deployment"  "avenger-frontend-services" {
  metadata {
    name = "avenger-frontend-services"
    labels = {
      App = "avenger-frontend-service"
    }
    namespace = kubernetes_namespace.events_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 90
    selector {
      match_labels = {
        App = "avenger-frontend-service"
      }
    }
    template {
      metadata {
        labels = {
          App =  "avenger-frontend-service"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.project_id}/${var.external_image_name}"
          name  = "avenger-frontend-service"

          env {
            name  = "SERVER"
            value = "http://avenger-backend-service:8082"
          }
          port {
            container_port = 8080
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}