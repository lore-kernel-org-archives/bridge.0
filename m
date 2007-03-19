Date: Mon, 19 Mar 2007 11:27:51 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070319112751.3a227ccd@dxpl.pdx.osdl.net>
In-Reply-To: <eth3uu$drn$1@sea.gmane.org>
References: <BB501CE635E5144CA5E30956E5E32C52271F0E@exchange-be5.lancs.local>
	<BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local>
	<eth3uu$drn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Performance loss with bridging+routing.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jason Lunz <lunz@falooley.org>
Cc: bridge@linux-foundation.org

On Sat, 17 Mar 2007 16:11:11 +0000 (UTC)
Jason Lunz <lunz@falooley.org> wrote:

> n.egi@lancaster.ac.uk said:
> > Has anyone had similar experience or I'm doing something wrong when
> > combining bridging and routing?  If this is a normal behaviour could
> > anyone tell me where and why the packets got dropped? Or why the
> > performance loss occurs?
> >
> > Any suggestions are very welcome.
> 
> I would try using oprofile to see where the most time is being spent.
> 

If you are doing simple bridging or routing performance is about
the same. I see about 380K packets per second or more depending
on bus speed and network interface card.

But if you do filtering then your performance can easily get CPU
limited, especially if you are doing connection tracking.  The problem
is that filtering ends up reading the whole packet.
