# Imperial911 Script

The **Imperial911** script is an essential addition to the *Imperial Duty* system, providing realistic and immersive emergency dispatch functionality within the game. By integrating with the *ImperialDuty* script, **Imperial911** allows users to send a `/911` command that alerts on-duty users. The script can also retrieve the name of the civilian from the *CivilianInt* script if a profile is set; otherwise, it uses the player's FiveM name.

---

## Features

- **Emergency Dispatch**: Send a `/911` emergency signal to on-duty personnel with detailed location information using the integrated "nearest-postal" script.
- **Civilian Integration**: Automatically pulls the civilian name from the *CivilianInt* script if set. If not available or the script isn't installed, the player's FiveM name is used.
- **Blip Configuration**: Configure whether to show a flashing circle on the map around the postal where a 911 call originated. This is set via a blip configuration in the script's settings (`config.lua`).

## Commands

| Command   | Description                                                                          |
|-----------|--------------------------------------------------------------------------------------|
| `/911`    | Sends an emergency signal to on-duty users, displaying the sender's location and name.|

---

Prerequisites
Before installing the Imperial911 script, ensure that you have the ImperialDuty script already installed and configured. You can download and set up the ImperialDuty script from its [GitHub](https://github.com/Zippy01/ImperialDuty/releases).


## Installation

Follow these steps to install the **Imperial911** script:

1. **Download the Script Files**  
   Download the latest release from this repository.

2. **Add to Your Server Resources**  
   Place the `Imperial911` folder into your server's resources directory.

3. **Community ID Configuration**  
   The script requires a `community ID` and `API Secret Key` from *Imperial CAD*. If not already set, follow these instructions:
   - Locate your community ID in *Admin Panel > Customization > Community ID*.
   - Add the following line to your `server.cfg` file:
     ```plaintext
     setr imperial_community_id "COMMUNITY_ID_HERE"
     setr imperialAPI "API_Secret_Key_HERE"
     ```
   - If your server already uses other *Imperial* scripts with this same configuration, you can skip this step.

4. **Setup Postal Script**  
   The *[Nearest Postal](https://github.com/DevBlocky/nearest-postal/releases)* script must be installed for accurate postals in the 911 dispatches. Ensure the resource name in the `config.lua` under the shared folder matches `"nearest-postal"`. If using a different postal script, adjust accordingly. (!This script will not work without a valid export and function!)

5. **Blip Configuration**  
   In the `config.lua` file, adjust the blip setting:
   - Set `Config.callBlip = true` to show a flashing circle on the map for 911 locations.
   - Set `Config.callBlip = false` for no map blip, only 911 messages in chat.

6. **Ensure Resources in `server.cfg`**  
   Add the following lines to your `server.cfg`:
   ```plaintext
   ensure ImperialDuty
   ensure nearest-postal
   ensure Imperial911
   ```

7. **Restart Your Server**  
   Restart your server to apply the changes.

---

## Requirements

- **ImperialDuty Script**: Must be installed.
- **CivilianInt Script**: Required for CAD name integration. If not installed, the script defaults to the player's FiveM name.
- **Postal Script**: "nearest-postal" by DevBlocky is recommended. Ensure the script is installed without the version number in its file name.

## Usage Notes

The **Imperial911** script should be used with the correct civilian profile active for full functionality. Without an active civilian profile or the *CivilianInt* script, the player's default FiveM name will be used for the 911 call.

---

### License

This script is owned by *Imperial Solutions*. Unauthorized copying, distribution, or use of this script without express permission is strictly prohibited and may result in legal actions.

---

For further assistance, visit the *Imperial Solutions* [Support Discord](https://discord.gg/N5UJBSDdsn) or refer to our support channels.
