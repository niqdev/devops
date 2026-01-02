import my_config

# debugging
print(my_config.labels)

# tests
assert len(my_config.labels) > 0, "labels can't be empty"
assert my_config.cpu > 256, "cpu cannot be less than 256"
# assert "foo" in labels, "foo label is a must"
