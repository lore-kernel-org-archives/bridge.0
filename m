Subject: Re: [Bridge] Re: Problem in changed VLAN code can cause systems to
	hang.
From: Tommy Christensen <tommy.christensen@tpack.net>
In-Reply-To: <20040910045603.32e8ded3@linux.site>
References: <414057B1.1020902@siennax.com>
	<20040909082129.62059694.davem@davemloft.net>
	<4405.131.188.28.69.1094744038.squirrel@www.osdl.org>
	<20040909085149.1d483349.davem@davemloft.net>
	<20040910045603.32e8ded3@linux.site>
Content-Type: text/plain
Message-Id: <1094819889.32556.63.camel@cyan.cph.tpack.net>
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
Date: Fri, 10 Sep 2004 12:38:19 -0000
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, bridge@lists.osdl.org

On Fri, 2004-09-10 at 13:56, Stephen Hemminger wrote:
> [root@dev4-009 root]# mii-tool eth2:1
> SIOCGMIIPHY on 'eth2:1' failed: Operation not supported

This is not the VLAN interface. It is typically named
eth2.1 (or possibly vlan1).
    ^

-Tommy


