Date: Tue, 30 Jan 2007 11:05:22 +1100
From: "Leigh Sharpe" <lsharpe@pacificwireless.com.au>
Message-ID: <H000006900127bb1.1170115520.mail.pacificwireless.net.au@MHS>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] VLAN headers disappearing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@lists.osdl.org>

Hi all, 
 I'm having trouble bridging VLANs.
By doing the following:

vconfig add eth1 10
vconfig add eth2 10
brctl addbr br10
brctl addif br10 eth1.10
brctl addif br10 eth2.10
ifconfig eth1.10 up
ifconfig eth2.10 up
ifconfig br10 up

I create a bridge which bridges packets tagged with VLAN ID 10.
Doing 

ebtables -A FORWARD --log -j ACCEPT

Results in lots of log entries in /var/log/messages, as one would expect.
However, 

ebtables -F
ebtables -A FORWARD -p 8021q --log -j ACCEPT

Results in absolutely nothing in /var/log/messages, which would indicate that at some point, the VLAN headers are disappearing from my bridged packets.

Having had somebody else have a look at this to confirm that I had it right, I got this response from them:

>  eth1 -> eth1.10 -> br0 -> eth2.10 -> eth2
>
>This works fine using *untagged* vlan packets.
>
>Using that layout with *tagged* vlan packets, however, reveals what
>seems to be a bug in the Linux bridge code in combination with the vlan
>code.
>
>I was able, in that configuration, to see tagged packets come in on eth1
>and eth1.10, and to see them matched by the ebtables rules on eth1.10.
>
>The *outbound* packets, on eth2, were sent as untagged Ethernet frames;
>something in the bridge or vlan process had stripped the vlan header
>entirely.
>
>I was able to reproduce this issue with a stock Linux 2.6.17 kernel,
>without any of my code involved, so I believe it to be a bug in the
>underlying kernel networking code.
>

So, is this a bug? Or have I got something horribly wrong?
 
Regards,
             Leigh
 
Leigh Sharpe
Network Systems Engineer
Pacific Wireless

