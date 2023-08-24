# CodeX Tanker

![SugarTank](https://github.com/5M-CodeX/codex-tanker/assets/112611821/66c89b9c-644e-4346-84eb-2b4370a11ba1)

This is a custom script for FiveM (a modification framework for Grand Theft Auto V) that allows players to fill up water tankers from designated refill locations.


# This is still in ALPHA STAGES

## Features

- Players can approach designated refill locations to start filling the water tanker.
- A progress bar is displayed at the top center of the screen while the tanker is being filled.
- Tanker speed is limited while being filled, preventing players from driving away.
- Notification system to inform players about the filling process and status.
- Option to reset the speed of the tanker after filling.

## Installation

1. Download the script files from this repository.

2. Copy the `codex-tanker` folder into the `resources` directory of your FiveM server.

3. Add `ensure codex-tanker` to your server's `server.cfg` file to ensure the script is started when the server launches.

## Usage

1. Drive a compatible tanker vehicle (as defined in the script configuration) to one of the refill locations (as defined in the configuration).

2. Approach the refill location and press the 'E' key to start the filling process.

3. A progress bar will appear at the top center of the screen, indicating the filling progress.

4. Once the tanker is filled, a notification will inform the player.

5. Optionally, you can use the `/draintanker` command to reset the tanker speed and empty it.

## Configuration

- The script includes a configuration file named `config.lua` that allows you to customize various settings such as refill locations, allowed vehicle models, and more.

## Credits

- The script was developed by TheStoicBear.
- Suggestion @TheStoicMW💚


## License

This script is licensed under the [MIT License](LICENSE).

---

For support and inquiries, please join https://discord.gg/suZaFCf75Y
