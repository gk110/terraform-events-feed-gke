resource "kubernetes_deployment" "avenger-backend-service" {
  metadata {
    name = "avenger-backend-service"
    labels = {
      App = "avenger-backend"
    }
    namespace = kubernetes_namespace.events_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "avenger-backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "avenger-backend"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.project_id}/${var.internal_image_name}"
          name  = "avenger-backend"

          env {
            name  = "GOOGLE_CLOUD_PROJECT"
            value = var.project_id
          }
          port {
            container_port = 8082
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