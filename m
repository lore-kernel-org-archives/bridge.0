Date: Thu, 17 Mar 2011 06:00:33 -0700 (PDT)
Message-Id: <20110317.060033.193708621.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4D81CDF6020000780003700B@vpn.id2.novell.com>
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<20110316082441.45db3018@nehalam>
	<4D81CDF6020000780003700B@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] build breakage due to br_multicast.c referencing
 ipv6_dev_get_saddr()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: JBeulich@novell.com
Cc: linus.luessing@web.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: "Jan Beulich" <JBeulich@novell.com>
Date: Thu, 17 Mar 2011 08:01:42 +0000

>>>> On 16.03.11 at 16:24, Stephen Hemminger <shemminger@linux-foundation.org>
> wrote:
>> On Wed, 16 Mar 2011 12:34:19 +0000
>> "Jan Beulich" <JBeulich@novell.com> wrote:
>> 
>>> With BRIDGE=y and IPV6=m commit
>>> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
>>> link-local address for multicast listener queries") causes the build to
>>> break.
>> 
>> Rather than continue with the config games, lets just make the necessary
>> ipv6 pieces accessible.
> 
> The below (however ugly it may look) seems to do the trick for me,
> for this particular symbol. Possibly other symbols need doing the
> same (didn't check which ones e.g. infiniband depends on), so
> some sort of abstraction might be desirable to make the whole
> thing look less ugly.

Sorry, we won't be doing things this way.  We created the disable
option exactly to handle this cleanly, and that is the way you
should take care of the situation you're in where you want to built
ipv6 modular yet have it disabled.
