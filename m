Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YOpc3bZiRWRriDSOObFG3Qsaf8uxGUEggNP5IeWWlyc=;
 b=Uq9i3WyVrsQvzUcGGl60mesNcqH8kUSz9cfz0yx+jCZu+S946JMHJL7esS8It0Etnm
 H1alD/laSVyanfu+OLGlYwuz8hgJVQCCScKBzrJhJB+qRmcQxvtw0uT7ay87Dgy3GCim
 qrx26IZ9MiZa5KQh4Q3QCgBAEshKCOyJDXlyQ=
References: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
 <20181116165001.30896-1-nikolay@cumulusnetworks.com>
 <20200423170521.65a3bc59@hermes.lan>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <137746b0-1655-3704-a6f1-54274615d605@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 10:26:51 +0300
MIME-Version: 1.0
In-Reply-To: <20200423170521.65a3bc59@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v3] net: bridge: fix vlan stats
 use-after-free on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

On 24/04/2020 03:05, Stephen Hemminger wrote:
> On Fri, 16 Nov 2018 18:50:01 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Syzbot reported a use-after-free of the global vlan context on port vlan
>> destruction. When I added per-port vlan stats I missed the fact that the
>> global vlan context can be freed before the per-port vlan rcu callback.
>> There're a few different ways to deal with this, I've chosen to add a
>> new private flag that is set only when per-port stats are allocated so
>> we can directly check it on destruction without dereferencing the global
>> context at all. The new field in net_bridge_vlan uses a hole.
>>
>> v2: cosmetic change, move the check to br_process_vlan_info where the
>>     other checks are done
>> v3: add change log in the patch, add private (in-kernel only) flags in a
>>     hole in net_bridge_vlan struct and use that instead of mixing
>>     user-space flags with private flags
>>
>> Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
>> Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Why not just use v->stats itself as the flag.
> Since free of NULL is a nop it would be cleaner?
> 

v->stats is *always* set while the vlan is published/visible, that's a guarantee
I don't want to break because I'll have to add null checks in the fast-path.

By the way this is a thread from 2018. :-)

Cheers,
 Nik

