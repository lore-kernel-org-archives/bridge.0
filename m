From: Bart De Schuymer <bdschuym@pandora.be>
Date: Sat, 16 Oct 2004 15:30:58 +0200
References: <411EAF08.3000401@shorewall.net>
	<200408192010.28417.bdschuym@pandora.be>
	<416DC6EF.9050001@shorewall.net>
In-Reply-To: <416DC6EF.9050001@shorewall.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410161530.58439.bdschuym@pandora.be>
Subject: [Bridge] Re: Policy match with a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tom Eastep <teastep@shorewall.net>
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org

On Thursday 14 October 2004 02:23, Tom Eastep wrote:
> Bart De Schuymer wrote:
> > On Monday 16 August 2004 03:31, Patrick McHardy wrote:
> >>The problem is ipv4_sabotage_out in the briding code. It prevents the
> >>packet from hitting the LOCAL_OUT hook while it is still unencrypted.
> >>When it hits the bridging code and its LOCAL_OUT hook it's too late.
> >>Not sure how to handle it yet.
> >
> > I'll have a look at that after I'm finished with the IPv6 bridge
>
> firewalling
>
> > stuff.
>
> Any progress on this?

You should be able to do what you want in the iptables mangle OUTPUT chain 
instead of the one in the filter table.
Patrick, a hack solution would be to temporarily change out->hard_start_xmit 
to something else than br_dev_xmit, that way you fool ipv4_sabotage_out.

cheers,
Bart

