Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hSFH235x9cvayA+gcxjI5JkciUVbvTnKLm9tJ6qXx/Q=;
 b=RoaJVcMtQo9mU3HFtbwl3tu+zHqk4lat8Xqkut7zuNzcbagfiONeeIAqKlkBzYQS2P
 18U2+lo/pdeU2HKByFWYxKVfRvpDcyIh1rUB3K+wrJR+qaXeY3gzWtYqVtcozb+iR1Re
 TtBhKPhZZhn0Oph9KcsjhFmEcGAM24DIcxJO+DPBaM0qws+pFRwXqlT/bQB/o+MAlJ3S
 Wl8O/uBjAbOrEv4n/PK+au2IHH5P1wiVq9ulRV+xGIQe+tq430xyAcZynxzGph7ZRs+b
 GtXeDm+uyYcHrEpPVXsfcTTxYyVArE7STev5Lit5n4knIg1igu4PCIhL3wf5tb037EnT
 g3/Q==
Date: Wed, 20 Oct 2021 08:19:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20211020081937.70059049@hermes.local>
In-Reply-To: <YW9qiUhDKT+56wkd@Laptop-X1>
References: <20211018082612.625417-1-liuhangbin@gmail.com>
 <ab707f4d-587a-0fae-e673-5da49f5946db@nvidia.com>
 <YW5a9JLnfZc1M8Gh@Laptop-X1>
 <a6bbd579-3d5f-6cbd-9523-49226a2b5a7a@nvidia.com>
 <YW9qiUhDKT+56wkd@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: Do not allow users to
 set IGMP counter/timer to zero
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, 20 Oct 2021 09:02:01 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Tue, Oct 19, 2021 at 07:09:42PM +0300, Nikolay Aleksandrov wrote:
> > > I started this patch when I saw there is not limit for setting
> > > multicast_membership_interval to 0, which will cause bridge remove the
> > > mdb directly after adding. Do you think this is a problem.
> > > 
> > > And what about others? I don't think there is a meaning to set other intervals
> > > to 0.
> > >   
> > 
> > The problem is not if there is meaning, we cannot start restricting option values now after
> > they've become uapi (and have been for a very long time) because we can break user-space even
> > though chances are pretty low. I don't think this patch is acceptable, I commented on the other
> > patch issues but they don't matter because of this.  
> 
> OK, I got your mean, we should not restrict the configurations based on whether
> there is a meaning.
> 
> Thanks
> Hangbin

Maybe the bridge command could enforce that the value set are sane relative
to the RFC?  We already fixup some things in iproute2 utilities to workaround
places where changing defaults in kernel would break userspace.
