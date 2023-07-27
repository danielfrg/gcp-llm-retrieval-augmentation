resource "google_storage_bucket" "data" {
  name          = var.bucket_name
  location      = "us-central1"
  storage_class = "STANDARD"

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "dummy_data" {
  name   = "contents/dummy.json"
  bucket = google_storage_bucket.data.name
  source = "data/one_vector.json"
}

resource "google_vertex_ai_index" "index" {
  region       = "us-central1"
  display_name = "test-index"
  description  = "index for test"

  metadata {
    contents_delta_uri = "gs://${google_storage_bucket.data.name}/contents"
    config {
      dimensions                  = 512
      approximate_neighbors_count = 150
      shard_size                  = "SHARD_SIZE_MEDIUM"
      distance_measure_type       = "DOT_PRODUCT_DISTANCE"
      algorithm_config {
        tree_ah_config {
          leaf_node_embedding_count    = 5000
          leaf_nodes_to_search_percent = 3
        }
      }
    }
  }
  index_update_method = "BATCH_UPDATE"

  depends_on = [
    google_storage_bucket_object.dummy_data
  ]
}

output "index_id" {
  value = google_vertex_ai_index.index.name
}

# INDEX ENDPONT

resource "google_vertex_ai_index_endpoint" "index_endpoint" {
  display_name = "sample-endpoint"
  description  = "A sample vertex endpoint"
  region       = "us-central1"
}

output "index_endpoint_id" {
  value = google_vertex_ai_index_endpoint.index_endpoint.name
}

