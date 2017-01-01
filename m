Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=e7s395/tKpODxFrxBpHdbsX+gXLd6aeLo4NT/hnbZcE=;
	b=ot1JgjyQaGPLg15LdetVGsgU/ujxEJeJ+zeb2Vl0gSehH7EThlhQYh0g43kEs4oIH4
	k1V2swL+e7vclRDw0v74//slkohyO9oronsKKSPbcUdgCwP6zN+Pqx2hKZuWdvw2LuDI
	fFRNDxL98N/6hvJnkGXm6LxEv5GlKkb44zzsNlBhQ+cVyaYYsqUjdSSkT0f06VxD4icR
	xXP164zsQsKvGWOHRgrRP393eeHKbArruaH/zLhtzWm0pbAJZJTPg0A43tRQSyamvh7Z
	Rxo+4IPEKrzBpONJ3ryJgWOJKZ5FLR/gngpHdwvb+s62A5xFCilNnBW/NUmegETPzHXY
	xv0A==
Date: Sun, 1 Jan 2017 10:22:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20170101102222.3d34c6ab@xeon-e3>
In-Reply-To: <20170101153749.GA1639@mbp>
References: <20170101153749.GA1639@mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge forwards ARP packets but not forwards IP
 datagrams
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cihangir Akturk <cakturk@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Sun, 1 Jan 2017 18:37:49 +0300
Cihangir Akturk <cakturk@gmail.com> wrote:

> Now the problem I am experiencing is that br0 bridge forwards ARP
> packets but not IP datagrams when they are sent from the host box.
> When I say "host box", I mean the machine on which my test VM runs.
> It seems that ARP packets are forwarded no matter which host (host
> or guest box) they come from. But when it comes to IP datagrams,
> they are forwarded to tap0 as expected if I send them from the same
> host as tap0 interface (guest VM). If I send them from the host
> box (I mean the computer on which my VM runs), IP datagrams reach
> br0 bridge, but somehow they are not forwarded to tap0 interface,
> I can see this with tcpdump.
> 
> I know the bridging functionality is independent of layer 3
> protocols, and it should forward packets according to their layer
> 2 addresses, in this case their mac addresses.


Short answer. It looks like you put an IP address on one of the devices
enslaved into the bridge.  Because of how the kernel L3 stack works you need
to only put IP addresses on the bridge device and not the underlying Ethernet
device. The only exception is if you are doing tricky things with brouting
in iptables.
