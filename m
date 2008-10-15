Message-ID: <fed120860810150738ob587c59u7dde88f1b02896e7@mail.gmail.com>
Date: Wed, 15 Oct 2008 20:08:02 +0530
From: "Srinivas M.A." <srinivas.aji@gmail.com>
In-Reply-To: <slrngfb6f9.ses.ahuxley@dione.no-ip.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
	<fed120860810131543w7a0ae9f7wf565d8dc10b06447@mail.gmail.com>
	<slrngfb6f9.ses.ahuxley@dione.no-ip.org>
Subject: Re: [Bridge] pinging other side (normal bridge ok,
	anonymous bridge not ok)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alexis Huxley <ahuxley@gmx.net>
Cc: bridge@osdl.org

> Yes, this is exactly what I need! I tried:
>
>        ifconfig dummy0 down      #  current holder of IP 192.168.1.42
>        ip link add name veth0 type veth peer name veth1
>        ifconfig veth0 192.168.1.42 up
>        ping 192.168.1.42         #  just checking :-)
>        brctl addif br0 veth1
>        iptables -A INPUT -i veth0 -j ACCEPT
>        ping 192.168.1.43
>
> but the ping still did not work. I also ACCEPTed traffic on veth1 and
> br0 but no difference. I'll flush all tables and do some more reading
> and gooling, but that must all wait till this evening.

Is veth1 up? (Maybe you need "ifconfig veth1 up".) You shouldn't need
the iptables line unless you have other iptables stuff that might
potentially block it. And there are some emails on the web referring
to issues with iptables conntrack and veth.
