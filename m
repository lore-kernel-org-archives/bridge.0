Date: Sat, 15 Mar 2008 10:14:02 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
In-Reply-To: <20080315120730.GB1766@mattstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <288286.64188.qm@web52410.mail.re2.yahoo.com>
Subject: Re: [Bridge] catching all packets on an interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Matt Richards <matt@mattstone.net>, Bridge Mailing List <bridge@linux-foundation.org>

Ah great I did not realize you could use physdev on
both.  My need was to pass all packets which go thru
the interface to QUEUE for mangling or at least
investigation (so ideally after fragments are
recombined and such).

I saw a nice flow diagram
(http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png)
 showing the interactions of bridged packets and
normal iptables flow.  It *seemed* like
prerouting/postrouting caught all local/passthru
packets coming in/out of the interface, so maybe:
iptables -I PREROUTING -m physdev --physdev-in eth0 -t
mangle -j QUEUE
iptables -I POSTROUTING -m physdev --physdev-out eth0
-t mangle -j QUEUE
?

-Scott


--- Matt Richards <matt@mattstone.net> wrote:

> Hello, 
> 
> by capture I'm guessing you mean match?
> 
> With bridges and iptables i normally use physdev
> 
> iptables -I FORWARD -m physdev --physdev-in eth0
> --physdev-out eth1
> 
> Hth,
> 
> Matt.
> 
> On Sat, Mar 15, 2008 at 04:50:39AM -0700, Scott
> MacKay wrote:
> > In a simple bridge design, eth0, eth1, bridged to
> br0,
> > what iptables rules would be needed to capture all
> of
> > the packets?
> > 
> > It looked like one in PREROUTING/mangle and
> > POSTROUTING/mangle would do it for all locally
> > delivered/received and passthru....
> > 
> > -Scott
> > 
> > 
> >      
>
____________________________________________________________________________________
> > Never miss a thing.  Make Yahoo your home page. 
> > http://www.yahoo.com/r/hs
> > _______________________________________________
> > Bridge mailing list
> > Bridge@lists.linux-foundation.org
> >
>
https://lists.linux-foundation.org/mailman/listinfo/bridge
> 
> -- 
> Matt Richards
> > _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
>
https://lists.linux-foundation.org/mailman/listinfo/bridge



      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
