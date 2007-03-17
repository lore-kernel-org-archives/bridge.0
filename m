From: Jason Lunz <lunz@falooley.org>
Date: Sat, 17 Mar 2007 16:11:11 +0000 (UTC)
Message-ID: <eth3uu$drn$1@sea.gmane.org>
References: <BB501CE635E5144CA5E30956E5E32C52271F0E@exchange-be5.lancs.local>
	<BB501CE635E5144CA5E30956E5E32C52271F0F@exchange-be5.lancs.local>
Sender: news <news@sea.gmane.org>
Subject: Re: [Bridge] Performance loss with bridging+routing.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

n.egi@lancaster.ac.uk said:
> Has anyone had similar experience or I'm doing something wrong when
> combining bridging and routing?  If this is a normal behaviour could
> anyone tell me where and why the packets got dropped? Or why the
> performance loss occurs?
>
> Any suggestions are very welcome.

I would try using oprofile to see where the most time is being spent.

Jason

