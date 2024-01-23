terramate {
  required_version = ">= 0.4.4"

  config {
    git {
      default_branch = "main"
    }
    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.terraform-cache-dir"
      }
    }
  }
}
