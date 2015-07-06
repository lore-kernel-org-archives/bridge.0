Return-Path: <prvs=6224e9363=julien.grall@citrix.com>
Message-ID: <559A5A0B.4040700@citrix.com>
Date: Mon, 6 Jul 2015 11:35:55 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
References: <1435946491-11148-1-git-send-email-julien.grall@citrix.com>
	<20150703204213.GM16529@breakpoint.cc>
In-Reply-To: <20150703204213.GM16529@breakpoint.cc>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: Add missing in6_dev_put in
	br_validate_ipv6
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

Hi,

On 03/07/15 21:42, Florian Westphal wrote:
> Julien Grall <julien.grall@citrix.com> wrote:
>> The commit efb6de9b4ba0092b2c55f6a52d16294a8a698edd "netfilter: bridge:
>> forward IPv6 fragmented packets" introduced a new function
>> br_validate_ipv6 which take a reference on the inet6 device. Although,
>> the reference is not released at the end.
>>
>> This will result to the impossibility to destroy any netdevice using
>> ipv6 and bridge.
>>
>> Spotted while trying to destroy a Xen guest on the upstream Linux:
>> "unregister_netdevice: waiting for vif1.0 to become free. Usage count = 1"
> 
> Ugh :-/
> 
> I think it makes more sense to use __in6_dev_get() instead which doesn't
> take a reference.

__in6_dev_get requires to hold rcu_read_lock or RTNL. My knowledge on
this code is very limited. Are we sure that one this lock is hold? At
first glance, I wasn't able to find one.

Regards,

-- 
Julien Grall
