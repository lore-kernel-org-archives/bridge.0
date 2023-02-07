Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B165041754
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3118C41751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOa+Kqn1wIq8P4WE7dtQrdMzw4uknucIa9WP/8Ju2Hk=;
 b=S56lhUA0tACEC44J6CHhidIAqcGL9Q7kRMOecJ/FdMuCGx2wp6x44f4335Fl+PjBredbmJy+2jHYGyNQi5bMuKt8DEeC0Ll5GqUcAc2zzbkWLy5tTP1YyNbdQgK+ygAgV0oScIkqLlJjQO9hZglQUH4UIWECZcv+v+XLClSJ94GGog9onSfaAOyH0rbcfo+o/Wdx548ggcXW9/C0IXqLosdR3IMBZFGOGV2VsJnBDVjJuo+jCXaV5kruCNYbUa5V3MA9WXH0hS4JcE/Mu96UYkr/MIjNylLrJzj/fmIxVG+kbSOGKr4h85AU0OTHRczgYIJTQ5joZVzc4UGei258Jw==
Date: Tue, 7 Feb 2023 11:25:36 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y+IZEJSwNZLH2aXN@shredder>
References: <20230204170801.3897900-1-idosch@nvidia.com>
 <3d7387d0-cff6-f403-55fc-1cb41e87db1a@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7387d0-cff6-f403-55fc-1cb41e87db1a@blackwall.org>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 00/13] vxlan: Add MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Tue, Feb 07, 2023 at 12:24:25AM +0100, Nikolay Aleksandrov wrote:
> Hmm, while I agree that having the control plane in user-space is nice,
> I do like having a relatively straight-forward and well maintained
> protocol implementation in the kernel too, similar to its IGMPv3 client
> support which doesn't need third party packages or external software
> libraries to work. That being said, I do have (an unfinished) patch-set
> that adds a bridge daemon to FRR, I think we can always add a knob to
> switch to some more advanced user-space daemon which can snoop.
> 
> Anyway to the point - this patch-set looks ok to me, from bridge PoV
> it's mostly code shuffling, and the new vxlan code is fairly straight-
> forward.

Thanks for taking a look. I was hoping you would comment on this
section... :)

After sending the RFC I realized that what I wrote about the user space
implementation is not accurate. An AF_PACKET socket opened on the VXLAN
device will only give you the decapsulated IGMP / MLD packets. You
wouldn't know from which remote VTEP they arrived. However, my point
still stands: As long as the kernel is not performing snooping we can
defer the forming of the replication lists to user space and avoid the
complexity of the "added_by_star_ex" entries (among many other things).
If in the future we need to implement snooping in the kernel, then we
will expose a new knob (e.g., "mcast_snooping", default off), which will
also enable the "added_by_star_ex" entries.

I tried looking what other implementations are doing and my impression
is that by "VXLAN IGMP snooping" they all refer to the snooping done in
the bridge driver. That is, instead of treating the VXLAN port as a
router port, the bridge will only forward specific groups to the VXLAN
port, but this multicast traffic will be forwarded to all the VTEPs.
This is already supported by the kernel.

Regarding what you wrote about a new knob in the bridge driver, you mean
that this knob will enable MDB lookup regardless of "mcast_snooping"?
Currently this knob enables both snooping and MDB lookup. Note that I
didn't add a new knob to the VXLAN device because I figured that if user
space doesn't want MDB lookup, then it will not configure MDB entries.

Thanks!
