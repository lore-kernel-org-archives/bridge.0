Return-Path: <marek@piasta.pl>
Date: Sun, 7 Jul 2013 21:56:34 +0200
From: Marek Kierdelewicz <marek@piasta.pl>
Message-ID: <20130707215634.1c63ed9e@catus>
In-Reply-To: <CAGZVhE1nOXBO_QiDX58xR3mu_sd6v2p3tiZPe+hKsJ3mS+UWEQ@mail.gmail.com>
References: <CAGZVhE1nOXBO_QiDX58xR3mu_sd6v2p3tiZPe+hKsJ3mS+UWEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Tap and Bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lambert Laurent <lambert.laurent91@gmail.com>
Cc: bridge@lists.linux-foundation.org

> Hi,

Hi,

>I'm currently trying to use bridge and tap for my work. In my setup I
>use two programs communicating though tap interface. I connect the two
>tap interface with a bridge.
>...
>Now comes the problem, currently only broadcast or multicast frames
>goes through the bridge. Every unicast frame get drop (or stuck)
>between the
>Did anyone this behavior in the past time ?

Yes. Try using veth pair interfaces:
ip link add name veth1 type veth peer name veth2
You'll get veth1 and veth2 pair that act as a "wormhole". Now add veth1
to the bridge and use veth2 with your program in the way you used tap.

If you need second pair just repeat procedure with different interface
names.

Best regards,
Marek Kierdelewicz
