From: Rajashekhar Mansanpally <raj@roinet.com>
Content-Type: text/plain
Message-Id: <1075830500.4867.116.camel@honeycomb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] priority number lower??
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Tue, 03 Feb 2004 17:48:30 -0000
To: bridge@lists.osdl.org
Cc: ebtables-devel@lists.sourceforge.net

In the past when I said:
ebtables -A INPUT -p 0x828 -j DROP    !!DOES NOT WORK!!
 
ebtables -A INPUT -p 0x800 -j DROP    !!WORKS!!

Group members told me that:
> What you need to do is register your function 
> on the existing NF_BR_PRE_ROUTING hook, with a priority number lower than 
> that of the ebtables nat PREROUTING chain (prio=NF_BR_PRI_NAT_SRC).

		      ebt INPUT
			|
			|
ebt (PREROUTING)------Bridging-----ebt (FORWARD)


I think my code is decapsulating (changing eth hdr) before INPUT chain
is traversed. So, I am confused as to what the priority number should
be.

Since encap/ decap functions are called by main code. If the prio is
Lower than NF_BR_PRI_NAT_SRC, encapsulation is taking place even before
ebt-PREROUTING chain is traversed. So is decapsulation.
Then I don't think I could filter the packets in the above fashion using
protocol 0x828.

So, I am wondering what is the right prio to choose. It is important I 
have a right piority.

Thanks in advance,

-Raj







