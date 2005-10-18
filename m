Message-ID: <BAY107-F513CA16D038A97C9816C388710@phx.gbl>
From: "Jonathan Chambers`" <chamber_j@hotmail.com>
Date: Tue, 18 Oct 2005 13:23:46 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Subject: [Bridge] Bridge Control using sysfs and Spinlocks
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am attempting to change the bridge kernel module so that I have complete 
control over the port states from user space via sysfs.

On code inspection I can see that whenever a reconfiguration of the bridge 
itself is made, i.e. ageing time, forward delay, hello time, etc. then there 
is a spin_lock_bh before the reconfiguration and a spin_unlock_bh after 
reconfiguration.

However, when a reconfiguration of a bridge PORT is made e.g. path cost, 
priority then the spin lock mechanism is not used. Is this correct 
operation? (The old ioctl method uses spin locks on bridge port 
reconfiguration, whereas I am reconfiguring via sysfs)

If I am to change the bridge module to accept requests to change the port 
state should I be using the spin locks?

Thanks in advance

Jon Chambers.

_________________________________________________________________
MSN Messenger 7.5 is now out. Download it for FREE here. 
http://messenger.msn.co.uk

