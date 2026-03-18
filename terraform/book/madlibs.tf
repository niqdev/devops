terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    local = {
      source = "hashicorp/local"
    }
    archive = {
      source = "hashicorp/archive"
    }
  }
}

# type coercion is the ability to convert any primitive type to its string representation
variable "words" {
  description = "A word pool to use for Mad Libs"
  type = object({
    nouns      = list(string),
    adjectives = list(string),
    verbs      = list(string),
    adverbs    = list(string),
    numbers    = list(number),
  })

  validation {
    condition     = length(var.words["nouns"]) >= 10
    error_message = "At least 10 nouns must be supplied."
  }
}

variable "num_files" {
  default = 100
  type    = number
}

locals {
  uppercase_words = { for k, v in var.words : k => [for s in v : upper(s)] }
}

# "count" is a meta argument, which means all resources intrinsically support it
# the address of a managed resource uses the format <RESOURCE TYPE>.<NAME>
# if "count" is set, the value of this expression becomes a list of objects
# representing all possible resource instances
# therefore, we could access the Nth instance in the list
# with bracket notation: <RESOURCE TYPE>.<NAME>[N]

# the expression "[][0]" always throws an error if it's evaluated
# (since it attempts to access the first element of an empty list)

resource "random_shuffle" "random_nouns" {
  #input = var.words["nouns"]
  count = var.num_files
  input = local.uppercase_words["nouns"]
}
resource "random_shuffle" "random_adjectives" {
  #input = var.words["adjectives"]
  count = var.num_files
  input = local.uppercase_words["adjectives"]
}
resource "random_shuffle" "random_verbs" {
  #input = var.words["verbs"]
  count = var.num_files
  input = local.uppercase_words["verbs"]
}
resource "random_shuffle" "random_adverbs" {
  #input = var.words["adverbs"]
  count = var.num_files
  input = local.uppercase_words["adverbs"]
}
resource "random_shuffle" "random_numbers" {
  #input = var.words["numbers"]
  count = var.num_files
  input = local.uppercase_words["numbers"]
}

# output "mad_libs" {
#   value = templatefile("${path.module}/templates/alice.txt", {
#     nouns      = random_shuffle.random_nouns.result
#     adjectives = random_shuffle.random_adjectives.result
#     verbs      = random_shuffle.random_verbs.result
#     adverbs    = random_shuffle.random_adverbs.result
#     numbers    = random_shuffle.random_numbers.result
#   })
# }

locals {
  templates = tolist(fileset(path.module, "templates/*.txt"))
}

resource "local_file" "mad_libs" {
  count    = var.num_files
  filename = "madlibs/madlibs-${count.index}.txt"
  content = templatefile(element(local.templates, count.index),
    {
      nouns      = random_shuffle.random_nouns[count.index].result
      adjectives = random_shuffle.random_adjectives[count.index].result
      verbs      = random_shuffle.random_verbs[count.index].result
      adverbs    = random_shuffle.random_adverbs[count.index].result
      numbers    = random_shuffle.random_numbers[count.index].result
  })
}

# terraform destroy will not delete madlibs.zip because this file isn’t a managed resource
# "data sources" do not implement Delete()
data "archive_file" "mad_libs" {
  depends_on  = [local_file.mad_libs]
  type        = "zip"
  source_dir  = "${path.module}/madlibs"
  output_path = "${path.cwd}/madlibs.zip"
}
