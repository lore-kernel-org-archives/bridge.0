Return-Path: <prvs=6224e9363=julien.grall@citrix.com>
Message-ID: <559A675B.80408@citrix.com>
Date: Mon, 6 Jul 2015 12:32:43 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
References: <1435946491-11148-1-git-send-email-julien.grall@citrix.com>
	<20150703204213.GM16529@breakpoint.cc>	<559A5A0B.4040700@citrix.com>
	<20150706111952.GC16864@breakpoint.cc>
In-Reply-To: <20150706111952.GC16864@breakpoint.cc>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Xen-devel] [PATCH] net/bridge: Add missing
	in6_dev_put in br_validate_ipv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: wei.liu2@citrix.com, ian.campbell@citrix.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Bernhard Thaler <bernhard.thaler@wvnet.at>, xen-devel@lists.xenproject.org, davem@davemloft.net, Pablo Neira Ayuso <pablo@netfilter.org>

On 06/07/15 12:19, Florian Westphal wrote:
> Julien Grall <julien.grall@citrix.com> wrote:
>> On 03/07/15 21:42, Florian Westphal wrote:
>>> I think it makes more sense to use __in6_dev_get() instead which doesn't
>>> take a reference.
>>
>> __in6_dev_get requires to hold rcu_read_lock or RTNL. My knowledge on
>> this code is very limited. Are we sure that one this lock is hold? At
>> first glance, I wasn't able to find one.
> 
> All netfilter hooks are rcu_read_locked via nf_hook_slow().

Ok. I will resend the patch with __in6_dev_get.

> BTW, netfilter patches should be sent to netfilter-devel@vger.kernel.org.

I used scripts/get_maintainer.pl which doesn't provide this mailing list
for net/bridge/br_netfilter*.c

Regards,

-- 
Julien Grall
