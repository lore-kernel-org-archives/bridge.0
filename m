Subject: Re: Re: [Bridge] The problem of bridge+netfilter+nat
From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <20050324162043.SM02616@zhengcb>
References: <20050324162043.SM02616@zhengcb>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 19:02:07 +0100
Message-Id: <1111687328.3388.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Zheng Chuanbo <zhengcb@netpower.com.cn>
Cc: bridge <bridge@lists.osdl.org>

Op do, 24-03-2005 te 16:25 +0800, schreef Zheng Chuanbo:
> Hi,
> 
> Thanks for reply.
> 
> There is no dhcp client on our firewall. I tried to get rid of the problem
> by blocking broadcast packets with the command below,
> 
> iptables -I FORWARD -d 192.168.0.255 -j DROP
> 
> But it still remained the same. So is there any quick solutions to that?
> Thanks.

Upgrade to a recent kernel or change net/core/dev.c::handle_bridge()
so that it looks like this (add the PACKET_LOOPBACK stuff):
	if ((*pskb)->pkt_type == PACKET_LOOPBACK ||
	    (port = rcu_dereference((*pskb)->dev->br_port)) == NULL)
		return 0;

cheers,
Bart


