if (requireNamespace("tinytest", quietly = TRUE)) {
  tinytest::test_package("tumr", pattern = "^[^_].*\\.[rR]$")
}
