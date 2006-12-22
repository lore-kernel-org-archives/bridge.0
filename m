From: Bart De Schuymer <bdschuym@pandora.be>
In-Reply-To: <458B7ADF.000035.18540@bj163app11.163.com>
References: <458B7ADF.000035.18540@bj163app11.163.com>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 22 Dec 2006 19:52:57 +0100
Message-Id: <1166813577.2947.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Can bridge be  'seen'  by ip6tables?
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: llsherry <llsherry@163.com>
Cc: bridge <bridge@lists.osdl.org>

Op vr, 22-12-2006 te 14:27 +0800, schreef llsherry:
>      Hello!    
> 
>      Recently,I’m doing a security project based upon ipv6.I have
> built up a bridge to support a transparent firewall.(my system is
> Fedora Core 2,kernel 2.6.5).In this system ,the version of the
> iptables is 1.2.7,which does not support ipv6(I have tried it).Thus,I
> download a new version and test it.
> 
>      The iptables functions in bridge mode,but the ipv6 doesn't work
> well.In the bridge mode,ip6tables can’t prevent the packet when I use
> “ip6tables CA FORWARD Cj DROP”. I use the
> command"ls/proc/sys/net/bridge",it shows
> bridge-nf-call-iptables,bridge-nf-call-arptables,bridge-nf-filter-vlan-tagged.The problem is I can't find bridge-nf-call-ip6tables.
> 
>      I have searched a lot of information,all said that the kernel2.6
> have the bridge-nf code.Could you please tell me how to let the
> bridged packets be 'seen' by ip6tables?

Support for IPv6 was added in a later kernel release.

cheers,
Bart



