#!/bin/bash

dotnet() {
  asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
  asdf install dotnet-core latest
  asdf global dotnet-core latest
}

node() {
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs latest
  asdf global nodejs latest
}

java() {
  asdf plugin-add java https://github.com/halcyon/asdf-java.git
  asdf install java latest
  asdf global java latest
}

all() {
  echo "Installing latest versions of Node.js, Java, and .NET..."
  dotnet
  node
  java
  echo "Node.js, Java, and .NET have been set up using asdf."
}

basic() {
  node
  dotnet
}

usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  --all                 Run all steps"
  echo "  --basic               Install only Node.js and .NET"
  echo " --[dotnet|node|java]   Install specific language"
  echo "  --help                Display this help message"
}

setup() {
  # Ensure asdf is installed
  if [ ! -d "$HOME/.asdf" ]; then
    echo "asdf not found, cloning repository..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  else
    echo "asdf already installed."
  fi

  # Source asdf
  echo "Sourcing asdf..."
  . $HOME/.asdf/asdf.sh

  # Add asdf plugins
  echo "Adding asdf plugins..."
}

main() {
  if [ "$#" -eq 0 ]; then
    usage
    exit 1
  fi

  setup

  case "$1" in
  --all) all ;;
  --basic) basic ;;
  --dotnet) dotnet ;; --node) node ;; --java) java ;; --help) usage ;;
  *)
    echo "Invalid option: $1"
    usage
    exit 1
    ;;
  esac
}

main "$@"

exit
