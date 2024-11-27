#!/bin/bash

# Ensure asdf is installed
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi

# Source asdf
. $HOME/.asdf/asdf.sh

# Add asdf plugins
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add java https://github.com/halcyon/asdf-java.git
asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git

# Install specific versions
asdf install nodejs latest
asdf install java latest
asdf install dotnet-core latest

# Set global versions
asdf global nodejs latest
asdf global java latest
asdf global dotnet-core latest

echo "Node.js, Java, and .NET have been set up using asdf."