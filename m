Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BmdHwMdoVV1uojD1b7m3r6B3O3TcQV4xN3eKKkwBr18=;
 b=Pd2yMa4wCxaOMJoaB/4JtonxeySiJYrWppqNbj6mLo+Xk7WLHyboyJHlSF363qMvY/
 43NORPTrnwI/JYL8h2kBaU/ZQ4iG+Kot/R9uitTExUsNQGpW6o0RccWoUqGEkBmBe2PG
 mKawAN9mekITRG5ys+7uxSMx009kHveHml2hggLs7C2BmYgApnkZg9Ns9eYGlU71qAbf
 qfVw9RoN6PYOrOcBb0JfEaRYXSvZDne/p1L7U1w0GzfN2vMPMG12bERngZZPsZ4PuJji
 ucaq2t3PaiRkXc4MFzVvx1UczqlSv/o9sMO1IE03u4SQwkrJv4Z8PWwD2bTea1wJUuHp
 IioA==
Date: Thu, 21 Oct 2021 09:08:34 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YXC9kgPGv+Xb85Sc@Laptop-X1>
References: <20211018082612.625417-1-liuhangbin@gmail.com>
 <ab707f4d-587a-0fae-e673-5da49f5946db@nvidia.com>
 <YW5a9JLnfZc1M8Gh@Laptop-X1>
 <a6bbd579-3d5f-6cbd-9523-49226a2b5a7a@nvidia.com>
 <YW9qiUhDKT+56wkd@Laptop-X1> <20211020081937.70059049@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020081937.70059049@hermes.local>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, Oct 20, 2021 at 08:19:37AM -0700, Stephen Hemminger wrote:
> > On Tue, Oct 19, 2021 at 07:09:42PM +0300, Nikolay Aleksandrov wrote:
> > > > I started this patch when I saw there is not limit for setting
> > > > multicast_membership_interval to 0, which will cause bridge remove the
> > > > mdb directly after adding. Do you think this is a problem.
> > > > 
> > > > And what about others? I don't think there is a meaning to set other intervals
> > > > to 0.
> > > >   
> > > 
> > > The problem is not if there is meaning, we cannot start restricting option values now after
> > > they've become uapi (and have been for a very long time) because we can break user-space even
> > > though chances are pretty low. I don't think this patch is acceptable, I commented on the other
> > > patch issues but they don't matter because of this.  
> > 
> > OK, I got your mean, we should not restrict the configurations based on whether
> > there is a meaning.
> > 
> > Thanks
> > Hangbin
> 
> Maybe the bridge command could enforce that the value set are sane relative
> to the RFC?  We already fixup some things in iproute2 utilities to workaround
> places where changing defaults in kernel would break userspace.

I'm afraid this may make user more confused. As user could also echo the
values via sys fs directly. e.g.

# ip link set br0 type bridge mcast_query_interval 0
Error: Invalid QI, must greater than 0.
# echo 0 > /sys/devices/virtual/net/br0/bridge/multicast_query_interval

Then ip -d link show br0 would show the mcast_query_interval is 0.

Thanks
Hangbin
