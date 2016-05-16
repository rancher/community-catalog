# asciinema.org

Record and share your terminal sessions, the right way.

asciinema is a free and open source solution for recording terminal sessions
and sharing them on the web.

This service uses the official [asciinema.org](https://hub.docker.com/r/asciinema/asciinema.org/) image. You can find asciinema.org's at [asciinema/asciinema.org](https://github.com/asciinema/asciinema.org/), asciinema's terminal recorder at
[asciinema/asciinema](https://github.com/asciinema/asciinema) and asciinema player at [asciinema/asciinema-player](https://github.com/asciinema/asciinema-player).

## How to use

After container starting, you'll need to exec `rbenv exec bundle exec rake db:setup` in asciinema/asciinema.org container to setup database, then modify $HOME/.config/asciinema/config to fit your needs.

You can override the address/port that is sent in email with login token by passing $host and $port environment variables when starting the service.
