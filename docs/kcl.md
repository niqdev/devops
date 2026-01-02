# KCL

> **KCL** is an open-source constraint-based record & functional language mainly used in configuration and policy scenarios

Resources

* [Documentation](https://www.kcl-lang.io)
* [KCL Tour](https://www.kcl-lang.io/docs/reference/lang/tour)
* [KCL extension](https://marketplace.visualstudio.com/items?itemName=kcl.kcl-vscode-extension) for Visual Studio Code

```sh
# installation
brew install kcl-lang/tap/kcl
```

## Examples

```sh
# execute program and output yaml
kcl kcl/examples/hello.k
kcl kcl/examples/server-1.k
kcl kcl/examples/server-2.k

# labs
kcl kcl/lab-1/my_config.k kcl/lab-1/my_config_test.k
kcl kcl/lab-1/my_config.k -D priority=2
```
