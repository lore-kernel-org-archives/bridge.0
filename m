Message-ID: <41C493D5.4080404@langhofer.at>
Date: Sat, 18 Dec 2004 21:32:21 +0100
From: armin langhofer <office@langhofer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge with ppp0, ppp1,..
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

hi there

i found your project and tried to bridge two ppp devices.


you say (http://bridge.sourceforge.net/faq.html) that this is possible:

... "Linux bridging is very flexible; the LAN's can be either 
traditional Ethernet device's, or pseudo-devices such as PPP, VPN's or 
VLAN's. The only restrictions are that the devices:" ...


i tried this but got "br_add_interface: Invalid argument" when adding a 
ppp device to the bridge. adding an ethernet device works perfectly!

00:07:21 protector ~ # brctl addbr br0
00:07:22 protector ~ # brctl addif br0 eth2
00:07:30 protector ~ # brctl addif br0 ppp0
br_add_interface: Invalid argument



the ppp's are done with pppd and pptpd (poptop)
00:09:39 protector ~ # pppd --version
pppd version 2.4.2
00:09:44 protector ~ # pptpd --version
PoPToP v1.1.4-b4


any ideas?

best regards, armin.
-- 
armin langhofer
snail:  fischer von erlachstr. 29
snail:  a-5020 salzburg
phone:  +43 699 11648495
email:  office@langhofer.at
gnupg:  http://langhofer.at/pubkey.txt

