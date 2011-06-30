From: Arnaud Fontaine <arnau@milkypond.org>
References: <878vsjqxjz.fsf@duckcorp.org>
	<20110630092258.7c1119a3@nehalam.ftrdhcpuser.net>
Date: Thu, 30 Jun 2011 21:58:31 +0200
In-Reply-To: <20110630092258.7c1119a3@nehalam.ftrdhcpuser.net>    (Stephen
	Hemminger's message of "Thu, 30 Jun 2011 09:22:58 -0700")
Message-ID: <87k4c38520.fsf@duckcorp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] Bridge interface always down since Linux >= 2.6.39
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

> There are  two flags, IFF_UP  - admin up/down and  IFF_RUNNING carrier
> up/down The IFF_UP is controlled manually, and IFF_RUNNING is what you
> are talking about.

Interesting, thank you very much for the explanation.

> In older  kernel versions, the  bridge device always  asserted carrier
> even if all  ports did not have carrier. Now it  reflects the state of
> the  underlying device.  In  your case  the  problem is  that the  tap
> interfaces aren't reporting carrier.

This  is what  I understood  by testing  with a  real  network interface
attached to the  bridge, however I was not sure  whether it was intended
or a regression.  In this  particular case, a tap interface is reporting
carrier when  an userspace program is  attached to it AFAIK,  so I guess
there  is  nothing else  I  can do  besides  of  attaching an  userspace
program, right?

Thanks for the quick response.

Cheers,
-- 
Arnaud Fontaine
