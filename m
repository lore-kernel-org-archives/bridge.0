From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Re: [2.4.22] bad interaction between e100 and bridge: BUG at dev.c:991!
Date: Wed, 3 Sep 2003 18:49:19 +0200
References: <p05111b01bb728bc8972e@[10.96.96.13]> <20030827132810.65010eac.shemminger@osdl.org> <p05111b01bb7a6c4659d6@[10.96.96.13]>
In-Reply-To: <p05111b01bb7a6c4659d6@[10.96.96.13]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031849.19208.bdschuym@pandora.be>
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Hannes Schulz <schulz@schwaar.com>, Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Wednesday 03 September 2003 16:56, Hannes Schulz wrote:
> If have just booted into 2.6.0-test4. Unplugging works, but the
> console is flooded with:
> last-F IN=br0 OUT=br0 PHYSIN=eth1 PHYSOUT=eth0 SRC=10.96.96.25
> DST=10.96.96.255
>
> [last-F ist the last rule in my FORWARDING iptable and does log+drop]
>
> Obviously I must allow forwarding br0 <=> br0.
>
> While I am writing this the counter on the FORWARDING rule -i br0 -o
> br0 -j ACCEPT has reaches 2000+ packets with eth0 unplugged and the
> kernel ist still running.
>
>
> In both 2.4.22 and 2.6.0-test4 all of netfilter and advanced routing
> ist set to M. In 2.6.0-test4 this includes ebtables.

Hi,
I don't quite get it, is the above text describing a problem?

On Wednesday 03 September 2003 17:38, Stephen Hemminger wrote:
>
> You enabled NETFILTER_DEBUG in your config

Enabling or disabling netfilter debugging has no effect on logged messages.
All messages on the bridge list about problems with these are from people 
using outdated 2.4 bridge-nf patches.

cheers,
Bart

