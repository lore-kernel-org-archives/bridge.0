Message-ID: <4D519986.7070000@ll.mit.edu>
Date: Tue, 8 Feb 2011 14:29:10 -0500
From: Jeff Mitchell <jmitchell@ll.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge suddenly only passes traffic if in promiscuous mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hello,

I have a bridge to various interfaces. There is an IP address on the 
bridge, and hosts on the interfaces connected to the bridge use the 
bridge's IP address as a gateway. STP is off and the forwarding delay is 
set to 0.

This has been working fine, however, today I needed to change around 
some IPv6 addresses on the connected hosts. I made the IPv6 changes and 
rebooted those boxes, only to find that suddenly no traffic -- IPv4 *or* 
IPv6 -- was passing through the bridge.

When I pulled up tshark to see what was going on, traffic suddenly 
started flowing again. And even as I type this, as long as tshark is 
running on that interface (no matter what the capture filter is), 
traffic is flowing. The moment I stop tshark from running, traffic 
stops. IOW, the bridge is only passing traffic while in promiscuous mode.

I didn't change the IP address on the bridge itself. As far as I can 
tell I didn't do anything odd whatsoever. But I have no idea what's 
causing this and I'd really like to not reboot the box if at all possible.

Does anyone have any idea what might be causing this and/or how to 
troubleshoot this?

Thanks,
Jeff
