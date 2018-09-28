# thesephist/dotfiles

Config, scripts, rc files 💻

## local/

These files are for "local" machine use, i.e. workstation use.

These assume a rich GUI available, and assumes these machines are where the great majority of file editing and actual development happens.

Configurations here will favor rich user interfaces and convenience over lightweightness, performance, and complexity.

## remote/

These files are for "remote" machine use, i.e. servers and containers use.

These assume I'm accessing the environment through SSH or another shell rather than a rich GUI, and assumes there's little actual development that happens, in lieu of administrative tasks or debugging.

Configurations here will favor performance, simplicity, low dependency on third-party code over convenience and rich user interfaces.

## ocf/

These files are very specifically for configuring the UC Berkeley's [Open Computing Facility workstations](https://www.ocf.berkeley.edu/).

OCF workstations are thin clients that load configurations from an NFS volume on login, and these dotfiles are copied over to the local sshfs for the session.

## sh/

These files are utility shell scripts that can work in a lot of different settings. The use case of each will be detailed within the script.

A great majority of these are for macOS / Linux + BSD environments, but Windows is not intentionally excluded.

