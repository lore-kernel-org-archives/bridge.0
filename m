MIME-Version: 1.0
In-Reply-To: <8cad0aa0912230102i7e2f165fib4002393cc3d8ad4@mail.gmail.com>
References: <8cad0aa0912230102i7e2f165fib4002393cc3d8ad4@mail.gmail.com>
Date: Wed, 23 Dec 2009 08:03:10 -0600
Message-ID: <2e59e6970912230603r9a875e6rb5bc0da53e7d6ba6@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] ebtables, PF_PACKET and other stuff
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Wed, Dec 23, 2009 at 3:02 AM, Jean-Michel Hautbois
<jhautbois@gmail.com> wrote:
> Hi there !
> I have been looking to the ebtables website, and in particular to the
> flowchart :
> http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png
>
> I am trying to have the following behaviour :
> On eth0, I have several types of frames, IP, 802.1Q and other things.
> I would like to have other things forwarded directly to eth1, and I
> would like to analyse the IP and 802.1Q frames.
> I mean : I don't want to see the frames in my local process.
>
> I have done the following :
> - Creating a bridge between eth0 and eth1, no stp.
> - ebtables -t broute -A BROUTING -p IPv4 -j DROP
> - ebtables -t broute -A BROUTING -p 802.1q -j DROP
>
> This seems to work, as no IP nor VLAN frames are going out from eth1.
> Then, my question is : How can I "listen" to eth0, in order to get the
> complete frames (I need all the ethernet frames when IP or 802.1Q). I
> thought about something like a PF_PACKET, but I am not sure if I need
> to be in promiscuous mode or not...
>
> I did some tries, but nothing worked, so I prefer asking :-).

Send those packets to the ULOG target when dropping them.

From the ebtables manpage:

ulog

The ulog watcher passes the packet to a userspace logging daemon using
netlink multicast sockets. This differs from the log watcher in the
sense that the complete packet is sent to userspace instead of a
descriptive text and that netlink multicast sockets are used instead
of the syslog. This watcher enables parsing of packets with userspace
programs
(snip)

> Thanks in advance !
> Best Regards,
> JM
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
