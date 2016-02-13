### locator.rb

Very basic script to locate a device using its unique mac address.

### Usage

`ruby locator.rb e8:4e:6:2b:82:34` will lookup that mac address on the network, prints the corresponding IP address and open the site.

If you don't yet know the Mac address of the device but have it's current IP, you can use `ruby locator.rb 192.168.1.69` or `ruby locator.rb` and you will be prompted for the IP.

You can modify the script to specify the Mac address, so `ruby locator.rb` will lookit up directly.
