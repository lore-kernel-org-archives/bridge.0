Message-ID: <455E1E72.5090503@asgardsrealm.net>
Date: Fri, 17 Nov 2006 15:41:22 -0500
From: "Jamin W. Collins" <jcollins@asgardsrealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Can the bridge MAC be controlled/changed?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I'm attempting to use a ethernet bridge to solve the following problem:

VM Ware's player allows a guest operating system to be bridged in with 
an existing network interface on the host operating system.  My problem 
is that the connected interface on my host system varies between my 
wired and wireless ports depending on my location.  So, I decided to try 
creating a bridge (br0) between the two interfaces (eth0 and eth1) and 
then configuring VM Ware to bridge to br0 instead of either eth0 or eth1.

This appears to work as expected with one caveat. When both interfaces 
are members of the bridge and the wired port is not connected, the 
bridge can not acquire and IP.  However, when the wired port is removed 
from the bridge it can acquire an IP.

Attempting to investigate this, I found that regardless of the order in 
which the interfaces are added to the bridge, the bridge always winds up 
with the MAC address of the wired port when both are members of the 
bridge.  If the wired port is removed (or not yet added) the MAC of the 
bridge is that of the wireless port.

So, it appears that as long as the bridge has the same MAC as the 
wireless it can acquire an IP over the wireless interface.

Is there a way to control the MAC address that gets assigned to the 
bridge interface?  Or is there a better way to accomplish my goal of 
being able to switch between wired and wireless ports while bridging in 
a VM guest?

-- 
Jamin W. Collins
