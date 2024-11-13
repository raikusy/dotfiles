function dco --description "An alias for docker compose (docker-compose)"
  if type -q docker compose
    docker compose $argv
  else if type -q docker-compose
    docker-compose $argv
  else
    echo "docker compose or docker-compose not found"
    echo "Please install docker compose"
    echo "  \`brew install docker-compose\`"
  end
end
