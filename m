Message-ID: <4C876530.5080107@muc.ccc.de>
Date: Wed, 08 Sep 2010 12:28:00 +0200
From: x@muc.ccc.de
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge interface mac address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

hi!

i'm using dynamips (router/switch emulator) and would like to have an interface on the host as a link to the 'emulated lab'. with dynamips, one of the host's interfaces can be used to connect to a port of the 'emulated lab'. dynamips obviously injects its packets into this interface, and sniffs for packets directed towards the 'emulated lab'.

now i just have a single physical interface on the host. and i don't want the lab-traffic to pass thru the physical interface (and productive segment connected to it).
so i thought hey, let's be clever, just create a bridge. we don't need any bridge-members (yet), we just want to use it for the dynamips link for now.

after a brctl addbr, i get a bridge-interface - with a mac of 00:00:00:00:00:00.
tried it anyway: it doesn't work (i see arp-requests from the host, i see arp-replies to the host - which the host obviously simply ignores, most probably because of the all-zero-mac).
turns out it's also not possible to change the mac - not even to a locally administered mac.

is there a special way to set the bridge's mac? actually i find it quite irritating that it's not simply possible to change it just like with any other interface!?

also i think it might not be wise to treat 00:00:00:00:00:00 special, filter it, or similar (after all it's a valid global unicast mac - assigned to xerox...).

regards,

	Chris
