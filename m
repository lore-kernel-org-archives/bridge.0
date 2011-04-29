Date: Fri, 29 Apr 2011 08:34:18 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110429083418.1ce9415c@nehalam>
In-Reply-To: <20110429.002530.112581952.davem@davemloft.net>
References: <4DBA830A020000780003ED5D@vpn.id2.novell.com>
	<20110429.002530.112581952.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: Module use count must be updated as
 bridges are created/destroyed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jeffm@suse.com, JBeulich@novell.com

On Fri, 29 Apr 2011 00:25:30 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: "Jan Beulich" <JBeulich@novell.com>
> Date: Fri, 29 Apr 2011 08:21:14 +0100
> 
> > Otherwise 'modprobe -r' on a module having a dependency on bridge will
> > implicitly unload bridge, bringing down all connectivity that was using
> > bridges.
> > 
> > Signed-off-by: Jan Beulich <jbeulich@novell.com>
> > Cc: Jeff Mahoney <jeffm@suse.com>
> 
> All network device drivers behave exactly the same way, when you rmmod
> the thing we unconfigure all the routes, addresses, etc. going through
> that device and let you unload it.
> 
> And this behavior is very much intentional.
> 
> Don't add an exception here.

Agreed.
