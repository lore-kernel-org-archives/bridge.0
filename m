Message-ID: <4141A5DB.9090507@siennax.com>
Date: Fri, 10 Sep 2004 15:02:19 +0200
From: Mark Ruijter <bridge@siennax.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Re: Problem in changed VLAN code can cause systems to
	hang.
References: <414057B1.1020902@siennax.com>	<20040909082129.62059694.davem@davemloft.net>	<4405.131.188.28.69.1094744038.squirrel@www.osdl.org>	<20040909085149.1d483349.davem@davemloft.net>
	<20040910045603.32e8ded3@linux.site>
In-Reply-To: <20040910045603.32e8ded3@linux.site>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, bridge@lists.osdl.org


> I can't reproduce the problem on a test machine (SMP) with eth0 (e100) and eth2 (e1000)
> Doesn't seem to hang either with commands or custom program.

I'll try to create a little tool to reproduce the problem.
In the mean time, did you try net-snmp and snmpwalk?

Mark.


-- 

