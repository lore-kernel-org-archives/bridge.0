Date: Fri, 7 Aug 2009 12:35:54 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090807123554.7c2bc27c@nehalam>
In-Reply-To: <004f01ca1792$b24a7a90$16df6fb0$@edu>
References: <0199E0D51A61344794750DC57738F58E6D6A6CD7F6@GVW1118EXC.americas.hpqcorp.net>
	<004f01ca1792$b24a7a90$16df6fb0$@edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] macvlan: add tap device backend
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>
Cc: ogerlitz@voltaire.com, herbert@gondor.apana.org.au, 'Arnd Bergmann' <arnd@arndb.de>, mst@redhat.com, "'Fischer,
	Anna'" <anna.fischer@hp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "'Paul Congdon (UC Davis)'" <ptcongdon@ucdavis.edu>, netdev@vger.kernel.org, evb@yahoogroups.com, davem@davemloft.net

On Fri, 7 Aug 2009 12:10:07 -0700
"Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu> wrote:

> Responding to Daniel's questions...
> 
> > I have some general questions about the intended use and benefits of 
> > VEPA, from an IT perspective:
> > 
> > In which virtual machine setups and technologies do you forsee this 
> > interface being used?
> 
> The benefit of VEPA is the coordination and unification with the external network switch.  So, in environments where you are needing/wanting your feature rich, wire speed, external network device (firewall/switch/IPS/content-filter) to provide consistent policy enforcement, and you want your VMs traffic to be subject to that enforcement, you will want their traffic directed externally.  Perhaps you have some VMs that are on a DMZ or clustering an application or implementing a multi-tier application where you would normally place a firewall in-between the tiers.

I do have to raise the point that Linux is perfectly capable of keeping up without
the need of an external switch.  Whether you want policy external or internal is
a architecture decision that should not be driven by mis-information about performance.
