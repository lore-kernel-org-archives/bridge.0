Message-ID: <407DFEE3.3000705@austin.rr.com>
Date: Wed, 14 Apr 2004 22:17:55 -0500
From: TC Hough <tchough@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Misbehaving bridge...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I'm trying to bridge a wired network and a wireless network, but I'm 
having some trouble.  No traffic seems to be passing through the 
bridge.  When I issue a "showmacs" command to brctl, I am able to see 
MAC addresses from both networks.  I am also able to ping both networks 
from the bridge machine.  When I issue a "showstp" command to brctl, the 
wireless access point that my card is connected to is shown as the root 
bridge no matter how low I set the bridge priority.  If I tell my 
wireless card to act as the master, the bridge seems to function perfectly.

The card I'm using is a D-Link DWL-520 Rev E1 with a Prism2.5 chipset 
using the HostAP drivers.  I read in the FAQ page that some wireless 
cards cannot act as bridges because they are unable to spoof MAC 
addresses.  I do not believe this to be the case with my card.  I am 
able to change my MAC address without problems by issuing the following 
command:

ifconfig wlan0 hw ether XXXXXXXXXXXX

The card functions normally with a fake MAC address.  It'll even show up 
on my access point's station list as the fake address.  So am I doing 
something wrong?  Should this work, or did I misunderstand the FAQ?  Is 
altering the MAC address a thorough enough test of whether my card is 
capable of being a wireless bridge? 

The bridge machine I'm using is an older PPC Macintosh running Debian 
unstable.  Could the architecture be a problem?

If it is impossible for me to bridge the networks when I am a wireless 
client in managed mode, would it be possible to bridge the hardware 
access point and this linux box functioning in master mode?

Thank you for your time,
TC

PS: If this is the wrong place to post these sorts of questions, I 
apologize for the inconvenience.


