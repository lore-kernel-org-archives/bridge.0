Message-ID: <bdfc5d6e0704050607h224bfc8wcfd6779786eade7d@mail.gmail.com>
Date: Thu, 5 Apr 2007 09:07:07 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <4614ED97.8090002@endian.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4614ED97.8090002@endian.it>
Subject: Re: [Bridge] strange networking behaviour with a bridge in game
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Peter Warasin <peter@endian.it>
Cc: bridge@osdl.org

On 4/5/07, Peter Warasin <peter@endian.it> wrote:
> hi list
>
> I have a strange problem here. Maybe it is normal behavior and i search
> within the wrong direction. Probably someone here can give me a hint.
>
> I have a device (rhel4 kernel 2.6.9) with 3 interfaces. 2 interfaces
> (eth0, eth2) are bridged together (br0) and the bridge device has an ip
> address assigned (192.168.11.15).
> Another interface (eth1) has assigned 10.7.0.10.
>
>
> So far so good. Everything is working well if traffic passes from
> 192.168.11.0/24 out to 10.7.0.0/24 if both networks are on different
> switches.
>
> The thing begins to become strange if both eth0 and eth1 are connected
> on the same switch (eth2 is not connected). So i have both subnets on
> the same switch (for testing purposes).
> If i then would like to access 192.168.11.15, packets reach the device
> through the interface eth1 instead of eth0/br0, which in fact is wrong.
> The arp table on the client shows this also. 192.168.11.15 is assigned
> to the mac adress of the interface eth1.
>
> Needless to say that this happens only from time to time. If i cleanup
> the arp table sometimes it went alright.
>
> What's wrong with my installation?
>
> Thank you in advance!
>
> peter
>
>
> --
> :: e n d i a n
> :: open source - open minds
>
> :: peter warasin
> :: http://www.endian.com   :: peter@endian.com
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>


Check out the ip sysctl/proc arp_ignore

net.ipv4.conf.tun0.arp_ignore = 0
net.ipv4.conf.eth0.arp_ignore = 0
net.ipv4.conf.lo.arp_ignore = 0
net.ipv4.conf.default.arp_ignore = 0
net.ipv4.conf.all.arp_ignore = 0

or

/proc/sys/net/ipv4/conf/tun0/arp_ignore
/proc/sys/net/ipv4/conf/eth0/arp_ignore
/proc/sys/net/ipv4/conf/lo/arp_ignore
/proc/sys/net/ipv4/conf/default/arp_ignore
/proc/sys/net/ipv4/conf/all/arp_ignore


arp_ignore - INTEGER
        Define different modes for sending replies in response to
        received ARP requests that resolve local target IP addresses:
        0 - (default): reply for any local target IP address, configured
        on any interface
        1 - reply only if the target IP address is local address
        configured on the incoming interface
        2 - reply only if the target IP address is local address
        configured on the incoming interface and both with the
        sender's IP address are part from same subnet on this interface
        3 - do not reply for local addresses configured with scope host,
        only resolutions for global and link addresses are replied
        4-7 - reserved
        8 - do not reply for all local addresses

        The max value from conf/{all,interface}/arp_ignore is used
        when ARP request is received on the {interface}
