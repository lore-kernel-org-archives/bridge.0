From: Jason Lunz <lunz@falooley.org>
Date: Mon, 12 Jan 2004 22:24:05 +0000 (UTC)
Message-ID: <slrnc067ht.bq1.lunz@absolut.localnet>
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<200401060013.38748.bdschuym@pandora.be>
	<lhr7yedkfn.fsf@dodo.bluetail.com>
	<slrnbvr1kp.gtv.lunz@absolut.localnet>
	<lh8ykczxqr.fsf@dodo.bluetail.com>
Sender: news <news@sea.gmane.org>
Subject: [Bridge] Re: Bridge and PACKET-socket
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

luke@bluetail.com said:
> Still, I find the current semantics of packet sockets on bridged ports
> pretty confusing. It took me a full day to figure out why I wasn't
> receiving the packets I wanted, even though tcpdump did.
>
> I applied my proposed fix in my local tree: I have a separate clone of
> the ptype_base hashtable dev.c for specific-protocol handlers that
> want to run before the bridge, and an ioctl to move a packet-socket
> into that table. That way the user can choose whether he wants to get
> packets from enslaved interfaces or not.

I'm not sure you need to do that. On frame recieve, the loop over
ptype_base happens twice on a bridge, once before the bridging and once
after. For locally-destined packets, that is. (br_pass_frame_up() ends
up using netif_rx, sending the frame through dev.c again, right?)

If you want to see frames before the bridge has a chance to mess
w/ them, then bind your packet socket to the slave interface; otherwise,
bind to the virtual-bridge interface. Will this work? forwarded packets
will be hooked into open packet sockets somewhere in the TX path, iirc.

I may be misunderstanding you, but have you explored this?

Jason

