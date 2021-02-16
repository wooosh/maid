package main

import (
  "os/user"
  "path/filepath"
  "fmt"
  "strings"
  "encoding/json"
  "io/ioutil"
  "os/exec"

  "github.com/google/go-jsonnet"
)

type action struct {
  Type string `json:"type"`

  // type: write
  Path string `json:"path"`
  Contents string `json:"contents"`

  // type: command
  Command string `json:"command"`
  Arguments []string `json:"arguments"`
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
    switch action.Type {
    case "write":
      path := action.Path
      if strings.HasPrefix(path, "~/") {
        path = filepath.Join(usr.HomeDir, path[2:])
      }
      fmt.Println("writing:", path)
      err := ioutil.WriteFile(path, []byte(action.Contents), 0644)
      check(err)

    case "command":
      fmt.Println("command:", action.Command, strings.Join(action.Arguments, " "))
      cmd := exec.Command(action.Command, action.Arguments...)

      out, err := cmd.Output()
      check(err)

      fmt.Println(string(out))

    default:
      fmt.Println("invalid command type: " + action.Type)
    }
  }
}
