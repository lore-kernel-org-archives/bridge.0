Message-ID: <41E299D4.2010605@redhat.com>
Date: Mon, 10 Jan 2005 10:05:56 -0500
From: Neil Horman <nhorman@redhat.com>
MIME-Version: 1.0
References: <20050110140638.GH7529@thunderchild.debian.net>
In-Reply-To: <20050110140638.GH7529@thunderchild.debian.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: tg3 bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gergely Madarasz <gorgo@broadband.hu>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

Gergely Madarasz wrote:
> Hello,
> 
> I've got a very strange problem. Lately I've been setting up my linux
> servers for network (layer2) redundancy with a bridge interface containing
> two ethernet interfaces connecting to two switches. So far I didn't have
> any problems with it, but now a very strange thing happens with a new
> server I'm installing. The server is an ibm x346 having two onboard
> BCM5721 cards, the switches are cisco 3550, and I've tested with kernel
> versions 2.6.10 and 2.4.28.
> 
> The bpdu's from the cisco switches simply cannot be seen on the server,
> causing loops in l2 traffic. I've tested with sticking a hub between the
> c3550 and the server, the switch sends out the bpdu's, but they are not
> seen by linux (running tethereal). This happens only on eth0, on eth1
> everything seems fine. Any IP traffic on eth0 goes through, no packet
> loss, no errors.
> 
> And something even more strange: if I do an 
> ifconfig eth0 0 up; brctl addif br0 eth0; 
> it seems to be working fine, if I do it the other way
> round, then the bpdu's sent by the switches are lost somewhere.
> 
> Considering all these, the problem seems to me a strange interaction
> between the bridge driver, the tg3 driver and the hardware in question. 
> 
> Any ideas? 
> 
> Greg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
It looks to me like either order should work just fine, as long as the 
IFF_PROMISC flag isn't cleared when you bring up the interface.  Is 
IF_PROMISC clear in ifconfig after you issue your ifconfig eth0 up command?

Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
