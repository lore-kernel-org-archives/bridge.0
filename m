Subject: Re: [Bridge] Bridge and PACKET-socket
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<200401060013.38748.bdschuym@pandora.be>
	<lhr7yedkfn.fsf@dodo.bluetail.com>
	<slrnbvr1kp.gtv.lunz@absolut.localnet>
From: Luke Gorrie <luke@bluetail.com>
In-Reply-To: <slrnbvr1kp.gtv.lunz@absolut.localnet>
Message-ID: <lh8ykczxqr.fsf@dodo.bluetail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Luke Gorrie <lgorrie@nortelnetworks.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Mon, 12 Jan 2004 21:02:46 -0000
To: Jason Lunz <lunz@falooley.org>
Cc: bridge@osdl.org

Jason Lunz <lunz@falooley.org> writes:

> luke@member.fsf.org said:
> > This still sounds like packet-socket territory to me. Wouldn't it be
> > better to clarify/extend the packet-socket interface to cover bridged
> > ports?
> 
> I think you can just use a packet socket with BPF; that's what dhcpd
> does and it doesn't seem to incur noticable overhead on non-dhcp
> traffic.

Good point. I had assumed that any per-packet overhead would be
unacceptable since the box has to get "maximum" throughput. But we're
already running a PACKET-socket based DHCP relay, and I don't think
that impacted performance measurably.

Thanks for the tip!

Still, I find the current semantics of packet sockets on bridged ports
pretty confusing. It took me a full day to figure out why I wasn't
receiving the packets I wanted, even though tcpdump did.

I applied my proposed fix in my local tree: I have a separate clone of
the ptype_base hashtable dev.c for specific-protocol handlers that
want to run before the bridge, and an ioctl to move a packet-socket
into that table. That way the user can choose whether he wants to get
packets from enslaved interfaces or not.

If Someone Important thinks that change sounds reasonable and should
be made in Linux then I can port it to 2.6 and send a patch.

Cheers,
Luke

