From: Jason Lunz <lunz@falooley.org>
Subject: Re: [Bridge] Bridge and PACKET-socket
Date: Thu, 8 Jan 2004 16:34:33 +0000 (UTC)
Message-ID: <slrnbvr1kp.gtv.lunz@absolut.localnet>
References: <lhznd2do0m.fsf@dodo.bluetail.com>
	<200401060013.38748.bdschuym@pandora.be>
	<lhr7yedkfn.fsf@dodo.bluetail.com>
Sender: news <news@sea.gmane.org>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

luke@member.fsf.org said:
> This still sounds like packet-socket territory to me. Wouldn't it be
> better to clarify/extend the packet-socket interface to cover bridged
> ports?

I think you can just use a packet socket with BPF; that's what dhcpd
does and it doesn't seem to incur noticable overhead on non-dhcp
traffic.

Jason

