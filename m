Date: Tue, 11 Jan 2005 09:52:16 +0100
From: Gergely Madarasz <gorgo@broadband.hu>
Subject: Re: [Bridge] Re: tg3 bridge problems
Message-ID: <20050111085216.GA10074@thunderchild.debian.net>
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<1105416406.4923.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105416406.4923.8.camel@localhost.localdomain>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Paul Schulz <pschulz@foursticks.com>
Cc: linux-net@vger.kernel.org, Neil Horman <nhorman@redhat.com>, bridge@lists.osdl.org

On Tue, Jan 11, 2005 at 02:36:46PM +1030, Paul Schulz wrote:
> Greetings,
> 
> This may be the problem that I have seen (and reported) previously...
> http://oss.sgi.com/projects/netdev/archive/2004-02/msg00442.html
> 
> One suggestion.. do a packet dump on an outgoing bridge port, and a 
> dump from a transmitting machine connected to the bridge. Compare the
> MD5 checksums.

Thanks for the idea, but it doesn't seem to help. I've modified the patch
to apply to my chipset revision (and added a debugging printk to make sure
I've hit the right chipset :)), but nothing really changed. I didn't
expect it to either, because this is not a transmit problem, but a
promiscuous receive problem of the driver/card.

Greg

