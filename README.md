# Name
Library map for studys

# DEMO
1.Click the pin and library's name on the top page.
2.You can see library's detail.
![demo](https://user-images.githubusercontent.com/83792679/139199193-59866df2-dde8-4ab1-b570-ba695828ebdc.gif)

# Features
'Library map for studys' is an application that allows you to find a library where you can study.
You can see whether the library has study space and outlet.
You can also check the list of libraries registered in the app on Google Map on the top page.
Let's share library information that can concentrate on studying.

# Requirement
* macOS
* docker

# Installation
Install homebrew
```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Install Docker
```
  brew update
  brew install caskroom/cask/brew-cask
  brew cask install docker
```

# Usage
Start Docker
```
  open /Applications/Docker.app
```
Clone project
```
  git clone https://github.com/taro5430/library_map.git
  cd library_map
```
Start application
```
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml build
  docker network create library_map-network
  docker-compose run app rails assets:precompile RAILS_ENV=development
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
  docker-compose exec app rails active_storage:install db:migrate RAILS_ENV=development
```
Access top page
```
  http://localhost:3000
```
Stop application
```
  docker-compose stop
```

# Note
I don't test environments under Windows.

# Author
Taro Abe

# License
