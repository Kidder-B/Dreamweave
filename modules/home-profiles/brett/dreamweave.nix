let
  flake.modules.homeManager."Brett" =
    { lib, ... }:
    {
      home.activation.updateGitRepo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        REPO_DIR="$HOME/Clan/Dreamweave"
        GIT_URL="git@github.com:Kidder-B/Dreamweave.git"

        mkdir -p "$HOME/Clan"

        if [ -d "$REPO_DIR/.git" ]; then
          echo "Updating existing git repo at $REPO_DIR"
          git -C "$REPO_DIR" pull --rebase
        else
          echo "Cloning git repo into $REPO_DIR"
          git clone "$GIT_URL" "$REPO_DIR"
        fi
      '';
    };
in
{
  inherit flake;
}
