Mime-Version: 1.0
Message-Id: <p05111b04bcd8e06e0455@[10.96.96.13]>
In-Reply-To: <E1BRpXa-0002dM-L9@www9.emo.freenet-rz.de>
References: <E1BRpXa-0002dM-L9@www9.emo.freenet-rz.de>
Date: Tue, 25 May 2004 13:42:07 +0200
From: Hannes Schulz <schulz@schwaar.com>
Subject: Re: [Bridge] ebtables rules dont work
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: monade@freenet.de, bridge@lists.osdl.org

At 11:45 Uhr +0200 23.05.2004, monade@freenet.de wrote:
Hello,
i have some problems with testing the ebtables on my machine.
It's a Vanilla Kernel 2.6.5 and I selected:

- [*] 802.1d Ethernet Bridging
- Netfilter iptables option

and all ebtables options to compile new for a bridge machine.
This works sucesfully and i installed ebtables v2.0.6.

Now my Problem is that all packets will be Droped in the Forward Chain.
It makes the appearance that it's unimportant wich rule i use.

Here my very simple rule Setup only for testing:
ebtables -P FORWARD DROP
ebtables -P INPUT DROP
ebtables -P OUTPUT DROP
ebtables -A FORWARD -p IPv4 --ip-proto tcp --ip-sport 80 -j ACCEPT

When i use iptables for filtering i can/must see the same effect.

What I'have done wrong ? forgot options in the kernel, forgot rules ?

I don't use ebtables myself but I think there is a rule missing:

	ebtables -A FORWARD -p IPv4 --ip-proto tcp --ip-dport 80 -j ACCEPT

Your rule only covers traffic server --> browser. My rule ACCEPTS the 
traffic from the browser to the web server.


Yours

Hannes Schulz
