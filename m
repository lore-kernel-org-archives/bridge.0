Date: Fri, 10 Sep 2004 16:01:12 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Bridge] Problem in changed VLAN code can cause systems to hang.
Message-Id: <20040910160112.7fcee529.davem@redhat.com>
In-Reply-To: <20040910061424.29657cf3@linux.site>
References: <414057B1.1020902@siennax.com>
	<1094820204.32553.67.camel@cyan.cph.tpack.net>
	<20040910061424.29657cf3@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: netdev@premium.geo.yahoo.akadns.net, bridge@lists.osdl.org, tommy.christensen@tpack.net

On Fri, 10 Sep 2004 06:14:24 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Thanks Tommy, the vlan MII ioctl pass through was passing the wrong device.

Good eyes Tommy.  I looked at that line many times
and couldn't see this obvious error.

Patch applied.
