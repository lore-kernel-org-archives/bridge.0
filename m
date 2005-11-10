Message-ID: <4372D918.3050209@bway.net>
Date: Thu, 10 Nov 2005 05:22:32 +0000
From: "Ryan B. Lynch" <rlynch@bway.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 'dhcpcd' fails when run on wireless-wired bridge device
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

I'm experiencing a DHCP client failure when running 'dhcpcd' on the
bridge interface itself.  Here are the basics:

"eth0" is ordinary, wired ethernet
"eth1" is a wireless 802.11b/g device (ipw2200 driver)

There is a working DHCP server on the wireless network, which has been
tested and works when trying to run 'dhcpcd' on the wireless device
itself.  At the beginning, everthing is "down" with no IP addresses
assigned.  I bring up the bridge and add the devices in this order:

    > ip link set eth0 up
    > ip link set eth1 up
    > iwconfig eth1 essid "my_essid"
    > iwconfig eth1 key "my_key"

    > (pause to let the wireless client associate)

    > brctl addbr br0
    > brctl addif br0 eth0
    > brctl addif br0 eth1
    > ip link set br0 up

Now, I try to get a DHCP lease for the "br0" device, using 'dhcpcd':

    > dhcpcd -C -t 10 -d br0

'dhcpcd' times out, never receiving a DHCP response.  The DHCP server
hears the DHCP request, though, and sends responses back--this is
confirmed with 'tcpdump' and by looking at the logs on the server.  It
appears that the client machine is ignoring or missing the DHCP
responses.  As noted above, this process works perfectly without the
bridging, when I just bring up "eth1" and run 'dhcpcd' on it--I get a
DHCP response, no problem.

The system logs on the client appear to agree with this, but I don't
understand most of what I see:

Nov  9 23:58:10 caffeine net.agent[3388]: how do I bring interfaces up
on this distro?
Nov  9 23:58:10 caffeine net.agent[3388]: add event not handled
Nov  9 23:58:10 caffeine kernel: device eth0 entered promiscuous mode
Nov  9 23:58:10 caffeine kernel: device eth1 entered promiscuous mode
Nov  9 23:58:11 caffeine kernel: br0: port 2(eth1) entering learning state
Nov  9 23:58:11 caffeine kernel: eth1: received packet with  own address
as source address
Nov  9 23:58:19 caffeine last message repeated 2 times
Nov  9 23:58:26 caffeine kernel: br0: topology change detected, propagating
Nov  9 23:58:26 caffeine kernel: br0: port 2(eth1) entering forwarding state
Nov  9 23:58:30 caffeine dhcpcd[3480]: timed out waiting for a valid
DHCP server response

The message "eth1: recieved packet with own address as source address"
seems like the culprit.  Is my bridge device, or the "eth1" interface
device, discarding the DHCP responses for some reason?  Why would it do
that?  Is this an expected behavior with bridges and DHCP clients?

Or is there something else I'm missing?

Thanks for taking the time to consider my problem--I'm just at a loss as
to what's happening.

Thanks,
Ryan B. Lynch
