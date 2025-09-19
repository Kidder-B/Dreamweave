{inputs, ...}:
{
  flake.modules.homeManager."Brett" = {
          home.packages = [
            # Option A: Use default configuration
            inputs.khanelivim.packages.x86_64-linux.default
	    ];
	    };
	    }

