From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Dec 2009 18:37:49 +0100
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200912181445.07756.arnd@arndb.de>
	<20091218092547.4ddfde58@nehalam>
In-Reply-To: <20091218092547.4ddfde58@nehalam>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912181837.50242.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH] iplink: add macvlan options for bridge mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: virtualization@linux-foundation.com, Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>

On Friday 18 December 2009, Stephen Hemminger wrote:
> On Fri, 18 Dec 2009 14:45:07 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Ping!
> > 
> > Stephen, I submitted this twice but never heard back from you.
> > The changes to macvlan have been merged in 2.6.33-rc1, so it
> > would be good to have this included as well.
> > 
> >       Arnd
> > 
> 
> iproute gets updated (after patch is in upstream). I haven't started
> on the 2.6.33 version yet.

Ok, thanks for the info. Tell me when/if I should resubmit.
I also have another (smaller) patch that also accepts the same
options for the macvtap driver, which is not upstream.
Should I also send that when the kernel code hits net-next,
2.6.34-rc1 or 2.6.34?

	Arnd
