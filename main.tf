resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}
resource "kubernetes_config_map" "script" {
  metadata {
    name = var.name
    namespace = var.create_namespace ? kubernetes_namespace.namespace.0.id : var.namespace
    labels = {
      app = var.name
    }
  }
  data = {
    "add-more-tags"  = data.template_file.script.rendered
  }
}
resource "kubernetes_daemonset" "name_tag_attach" {
  metadata {
    name = var.name
    namespace = var.create_namespace ? kubernetes_namespace.namespace.0.id : var.namespace
    labels = {
      app = var.name
    }
  }
  spec {
    selector {
      match_labels = {
        "app" = var.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.name
        }
      }
      spec {
        init_container {
          name = var.name
          image = "amazon/aws-cli:2.0.15"
          command = ["/bin/bash", "/add-more-tags.sh"]
          volume_mount {
            mount_path = "/add-more-tags.sh"
            name = "script"
            sub_path = "add-more-tags"
          }
          env {
            name = "NODE_NAME"
            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }
          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }
          env {
            name = "POD_IP"
            value_from {
              field_ref {
                field_path = "status.podIP"
              }
            }
          }
        }
        container {
          name = "pause"
          image = "gcr.io/google_containers/pause"
        }
        volume {
          config_map {
            default_mode = "0777"
            name = kubernetes_config_map.script.metadata[0].name
          }
          name = "script"
        }
      }
    }
  }
}
