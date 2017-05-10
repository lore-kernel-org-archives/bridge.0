Return-Path: <fredrik.markstrom@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=t+eejlVZQeao3Y0eESvfl2DrtLlrc6VOIWygWnGHtyY=;
	b=Npn+FxD5S9nC9J9zQX/0YiYK4W5X1viQBjdZNfcM5ZPhrV1PnDnoLXNyRrHfkixcFZ
	duJBrbBd78ZotC5tCo6L9xTxKKM+qWl3xAlXMYhZyLfZq/pP54TOpMZVuKLp0k4l2msj
	nlOuJikbk0smADppKMYit6Jsw4vnjBeCkeKBwyJ4CoPfSFL3jLMXEipnepk1HdLdR8qG
	0rE9auj+aN89ZVruFgzbAf1zXOU0I0s2LP89cGh9PWZod71FzYIApG937oWrUoTxTx7L
	KcbC1eO189L3l5EKvs5d+nXXWmHrzmPut+LiHSGljVHIqHWUJ0nSE/hqksiLyFvmWwbt
	/nWw==
MIME-Version: 1.0
In-Reply-To: <20170509.134839.2008658486655854998.davem@davemloft.net>
References: <20170509124439.45674-1-fredrik.markstrom@gmail.com>
	<20170509.134839.2008658486655854998.davem@davemloft.net>
From: =?UTF-8?Q?Fredrik_Markstr=C3=B6m?= <fredrik.markstrom@gmail.com>
Date: Wed, 10 May 2017 02:42:47 +0200
Message-ID: <CAKdL+dQh9ZEWZKHam0Z3iaVpxgZY0mziT3ZWN1OcuS55zUjEXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH 0/2] net: Set maximum receive packet size on
	veth interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org

On Tue, May 9, 2017 at 7:48 PM, David Miller <davem@davemloft.net> wrote:
>
> From: Fredrik Markstrom <fredrik.markstrom@gmail.com>
> Date: Tue,  9 May 2017 14:44:36 +0200
>
> > Currently veth drops all packets larger then the mtu set on the
> > receiving end of the pair. This is inconsistent with most hardware
> > ethernet drivers.
>
> False.
>
> In fact, many pieces of ethernet hardware a not physically capable of
> sending even VLAN packets that are above the normal base ethernet MTU.
>

Maybe I was unclear, the veth implementation drops all packers larger then the
configured MTU (on the receiving interface).
Most ethernet drivers accepts packets up to the ethernet MTU no matter the
configured MTU. As far as I can tell from the RFC:s that is ok.

A simpler solution would be to only drop packets larger then ethernet MTU (like
most network drivers), but I guess that will break existing stuff
already out there.

The example below demonstrates what behaviour I'm referring to.

Example:
---- 8< ------
# veth0 and veth1 is a veth pair and veth1 has ben moved to a separate
network namespace.
% # NS A
% ip address add 1.2.3.4/24 dev veth0
% ip link set veth0 mtu 300 up

% # NS B
% ip address add 1.2.3.5/24 dev veth1
% ip link set veth1 mtu 1000 up
% ping -c 1 -W 1 -s 400 1.2.3.4
PING 1.2.3.4 (1.2.3.4) 400(428) bytes of data.

--- 1.2.3.4 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms
---- 8< ------

While it works fine in most setup:s with hw-interfaces:

---- 8< ------
# Host A eth2 and Host B eth0 is on the same network.

# On HOST A
% ip address add 1.2.3.4/24 dev eth2
% ip link set eth2 mtu 300 up

% # HOST B
% ip address add 1.2.3.5/24 dev eth0
% ip link set eth0 mtu 1000 up
% ping -c 1 -W 1 -s 400 1.2.3.4
PING 1.2.3.4 (1.2.3.4) 400(428) bytes of data.
408 bytes from 1.2.3.4: icmp_seq=1 ttl=64 time=1.57 ms

--- 1.2.3.4 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 1.573/1.573/1.573/0.000 ms
---- 8< ------

>
> It is therefore untenable to remove this restriction univerally like
> this.

With the explaination above, do you still think it's untenable ?

/Fredrik
