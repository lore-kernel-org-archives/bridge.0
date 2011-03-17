Message-ID: <4D821073.20602@hp.com>
Date: Thu, 17 Mar 2011 09:45:23 -0400
From: Brian Haley <brian.haley@hp.com>
MIME-Version: 1.0
References: <4D80BC5B0200007800036D85@vpn.id2.novell.com>
	<4D80F494.6050906@hp.com>
	<4D81CCF80200007800036FFD@vpn.id2.novell.com>
In-Reply-To: <4D81CCF80200007800036FFD@vpn.id2.novell.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Jan Beulich <JBeulich@novell.com>
Cc: linus.luessing@web.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On 03/17/2011 03:57 AM, Jan Beulich wrote:
>>>> On 16.03.11 at 18:34, Brian Haley <brian.haley@hp.com> wrote:
>> On 03/16/2011 08:34 AM, Jan Beulich wrote:
>>> With BRIDGE=y and IPV6=m commit
>>> fe29ec41aaa51902aebd63658dfb04fe6fea8be5 ("bridge: Use IPv6
>>> link-local address for multicast listener queries") causes the build to
>>> break.
>>>
>>> Similary, even if both are =m, but ipv6.ko got blacklisted (as is
>>> happening in various SuSE distros when disabling IPv6), there's
>>> a runtime problem since bridge.ko then won't load anymore due
>>> to the missing symbol.
>>
>> Load the ipv6 module with disable=1, which is why I added it :)
> 
> Indeed, I realized there is such an option only after I sent
> that mail. Nevertheless, I think it is overkill to load a huge
> module like this just to satisfy never actually used symbol
> references.

I could also argue that the bridge code could change into IPv4-only
and IPv6-only pieces to avoid this too (without actually looking
at the code of course).  But in this case you actually built the kernel
with IPV6=m right?

> In fact, just like it seems bogus to load ipv6.ko in a pure IPv4
> environment, I think the opposite is also true: IPv4 support
> should be in a module, and it should be possible to not load
> it in a pure IPv6 environment.

That's a much bigger nut to crack...

-Brian
