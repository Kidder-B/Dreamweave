{
  flake.modules.homeManager."Brett" =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        plugins = with pkgs.hyprlandPlugins; [
          hypr-dynamic-cursors
        ];
        extraConfig = ''
          plugin:dynamic-cursors {

              # enables the plugin
              enabled = true

              # sets the cursor behaviour, supports these values:
              # tilt    - tilt the cursor based on x-velocity
              # rotate  - rotate the cursor based on movement direction
              # stretch - stretch the cursor shape based on direction and velocity
              # none    - do not change the cursors behaviour
              mode = stretch

              # minimum angle difference in degrees after which the shape is changed
              # smaller values are smoother, but more expensive for hw cursors
              threshold = 2

              # apply a 90° offset in rotate mode to the text shape
              shaperule = text, rotate:offset: 90

              # use stretch mode when grabbing, and set the limit low
              shaperule = grab, stretch, stretch:limit: 2000

              # do not show any effects on clientside cursors
              shaperule = clientside, none

              # for mode = rotate
              rotate {

                  # length in px of the simulated stick used to rotate the cursor
                  # most realistic if this is your actual cursor size
                  length = 20

                  # clockwise offset applied to the angle in degrees
                  # this will apply to ALL shapes
                  offset = 0.0
              }

              # for mode = tilt
              tilt {

                  # controls how powerful the tilt is, the lower, the more power
                  # this value controls at which speed (px/s) the full tilt is reached
                  # the full tilt being 60° in both directions
                  limit = 5000

                  # relationship between speed and tilt, supports these values:
                  # linear             - a linear function is used
                  # quadratic          - a quadratic function is used (most realistic to actual air drag)
                  # negative_quadratic - negative version of the quadratic one, feels more aggressive
                  # see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
                  function = negative_quadratic

                  # time window (ms) over which the speed is calculated
                  # higher values will make slow motions smoother but more delayed
                  window = 100
              }

              # for mode = stretch
              stretch {

                  # controls how much the cursor is stretched
                  # this value controls at which speed (px/s) the full stretch is reached
                  # the full stretch being twice the original length
                  limit = 3000

                  # relationship between speed and stretch amount, supports these values:
                  # linear             - a linear function is used
                  # quadratic          - a quadratic function is used
                  # negative_quadratic - negative version of the quadratic one, feels more aggressive
                  # see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
                  function = quadratic

                  # time window (ms) over which the speed is calculated
                  # higher values will make slow motions smoother but more delayed
                  window = 100
              }

              # configure shake to find
              # magnifies the cursor if its is being shaken
              shake {

                  # enables shake to find
                  enabled = false

                  # use nearest-neighbour (pixelated) scaling when shaking
                  # may look weird when effects are enabled
                  nearest = true

                  # controls how soon a shake is detected
                  # lower values mean sooner
                  threshold = 6.0

                  # magnification level immediately after shake start
                  base = 4.0
                  # magnification increase per second when continuing to shake
                  speed = 4.0
                  # how much the speed is influenced by the current shake intensitiy
                  influence = 0.0

                  # maximal magnification the cursor can reach
                  # values below 1 disable the limit (e.g. 0)
                  limit = 0.0

                  # time in millseconds the cursor will stay magnified after a shake has ended
                  timeout = 2000

                  # show cursor behaviour `tilt`, `rotate`, etc. while shaking
                  effects = false

                  # enable ipc events for shake
                  # see the `ipc` section below
                  ipc = false
              }
          }
        '';
      };
    };
}
