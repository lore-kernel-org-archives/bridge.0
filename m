Message-ID: <4443D7C2.7030901@trash.net>
Date: Mon, 17 Apr 2006 20:00:34 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: [Bridge] Re: No UDP NFS over bridges in Linux 2.6.16.x?
References: <20060414235008.66335.qmail@web52913.mail.yahoo.com>
	<44408207.1070404@osdl.org>
In-Reply-To: <44408207.1070404@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org, nfs@lists.sourceforge.net, Chris Rankin <rankincj@yahoo.com>

Stephen Hemminger wrote:
> Then get a packet trace of a failing session with tcpdump. You may need
> to get two, one
> one the client and one on the server to be able to see which packet
> isn't getting past the
> bridge.

I only saw half of this thread (Chris' mails haven't made it to the list
yet), but in case you're using bridge-netfilter and conntrack, its most
likely because of conntrack fragmentation changes in 2.6.16. Conntrack
defragments packets, but relies on the IP layer to do the
refragmentation now. With purely bridged traffic, the packets don't go
through the IP layer, so they exceed the MTU of the outgoing bridge
port. 2.6.16.6 will include a fix for this problem:

[patch 06/22] NETFILTER: Fix fragmentation issues with bridge netfilter
