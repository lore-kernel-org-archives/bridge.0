Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sgDW0EeKIbc+tXjRijAMbaibbrP+Mz/1SBwo8s0GZRs=;
 b=bHeGJQpbkzoTrOkfCmMFaZkuTpg5QP5tMmyTlG8ndVg9eD+zGCnzPv7A2aI22Lmxia
 XHL5utpReYqP9T/3rMhb8joLsWDGFSJggm5MFwVMzWxgZC45U5JVUKhOaY6JhEdpbUr0
 PmynGgOCXXPAn8691qSlko5mP/2C94gMR9qK+WBAWJcNVLvffSxSSiBauH+8MNi5Qe4v
 hfQVd7b76yCpAM54eJJaxCO9VpuqbEFS0MqmL80AyPAPTwh6crTMCu8mQsCaJaOc//4M
 UK6gxB62fXVUdjDbnQ0FDopH+swhy+Ly1PclxpHSGQFWHM4eKlqccpyxchnP+z6ap0MI
 Odqw==
References: <20210719170637.435541-1-razor@blackwall.org>
 <875yw1qv9a.fsf@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
Message-ID: <458e3729-0bf0-8c45-9e45-352da76eaeb6@blackwall.org>
Date: Thu, 19 Aug 2021 19:22:44 +0300
MIME-Version: 1.0
In-Reply-To: <875yw1qv9a.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 00/15] net: bridge: multicast: add
	vlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

On 19/08/2021 19:01, Joachim Wiberg wrote:
> Hi Hik, everyone!
> 

Hi,
> On Mon, Jul 19, 2021 at 20:06, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>> This patchset adds initial per-vlan multicast support, most of the code
>> deals with moving to multicast context pointers from bridge/port pointers.
> 
> Awesome work, this looks very interesting! :)  I've already built and
> tested net-next for regressions on Marvell SOHO switches, looking good
> so far.
> 
> Curious, are you planning querier per-vlan, including use-ifaddr support
> as well?  In our in-house hack, which I posted a few years ago, we added
> some "dumpster diving" to inet_select_addr(), but it got rather tricky.
> So I've been leaning towards having that in userspace instead.
> 

Yes, that is already supported (use-ifaddr needs attention though). In my next
patch-set where I added the initial global vlan mcast options I added control
for per-vlan querier with per-vlan querier elections and so on. The use-ifaddr
needs more work though, that's why I still haven't added that option. I need
to add the per-vlan/port router control option so we'll have mostly everything
ready in a single release.

>> Future patch-sets which build on this one (in order):
>>  - iproute2 support for all the new uAPIs
> 
> I'm very eager to try out all the new IGMP per-VLAN stuff, do you have
> any branch of the iproute2 support available yet for testing?  For now
> I've hard-coded BROPT_MCAST_VLAN_SNOOPING_ENABLED in br_multicast_init()
> as a workaround, and everything seems to work just as expected :-)

I don't have it public yet because I need to polish the support, currently
it's very rough, enough for testing purposes for these patch-sets. :)
I plan to work on that after I finish with the per-vlan/port router control.

> 
> Best regards
>  /Joachim
> 

Thanks,
 Nik

