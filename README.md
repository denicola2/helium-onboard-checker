# helium-onboard-checker
A simple bash script to check if a maker has populated enough DC to onboard additional hotspots.
Tested on: Ubuntu 20.04

## Dependencies
- sendmail: follow instructions [HERE](https://linuxhint.com/bash_script_send_email/) to setup and configure sendmail
- jq and curl: `sudo apt install -y jq curl`

## Executing the script
- Usage as follows:
`./checker.sh 14rb2UcfS9U89QmKswpZpjRCUVCVu1haSyqyGY486EvsYtvdJmR "SyncroB.it" user@gmail.com`

## Args:
- maker account id as seen on Helium Explorer: https://explorer.helium.com/iot/makers
- maker name in plaintext
- destination email address

## Executing using cron
- Check available maker onboards every hour:
- Run `crontab -e`
- Add the following line:
` 0  *    *   *   *   /path/to/script/checker.sh 14rb2UcfS9U89QmKswpZpjRCUVCVu1haSyqyGY486EvsYtvdJmR "SyncroB.it" user@gmail.com`

# Sample email received
![image](https://user-images.githubusercontent.com/8965585/201396618-e2101a29-9314-4db3-8811-dbc9c49bd63a.png)
