package main

import (
  "os/user"
  "path/filepath"
  "fmt"
  "strings"
  "encoding/json"
  "io/ioutil"

  "github.com/google/go-jsonnet"
)

type action struct {
  Path string `json:"path"`
  Contents string `json:"contents"`
}

func check(err error) {
  if err != nil {
    panic(err)
  }
}

func main() {
  usr, err := user.Current()
  check(err)

  vm := jsonnet.MakeVM()

  script := "{"

  modules, err := ioutil.ReadDir("modules")
  check(err)

  for _, module := range modules {
    if !module.IsDir() && strings.HasSuffix(module.Name(), ".libsonnet") {
      script +=
        strings.TrimSuffix(module.Name(), ".libsonnet") +
        ": import 'modules/" + module.Name() + "',"
    }
  }

  script += "}"

  vm.TLACode("modules", script)

  actionsJson, err := vm.EvaluateFile("maid.jsonnet")
  check(err)

  var actions []action
  err = json.Unmarshal([]byte(actionsJson), &actions)
  check(err)

  for _, action := range actions {
    path := action.Path
    if strings.HasPrefix(path, "~/") {
      path = filepath.Join(usr.HomeDir, path[2:])
    }
    fmt.Println("writing ", path)
    err := ioutil.WriteFile(path, []byte(action.Contents), 0644)
    check(err)
  }
}
