Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XHt+FuftJsPGeqKy6heDhwHg5C+HSjbnEYws52bz+vg=;
 b=iG8USReCJE1ztEZykLXV7uL9Fy8/axncNlw+Bv/Q61VZ+IWsyngZOqRASZ6M5x44qB
 EOc/OWaB1foWWTqyCLHFzJ2IbhUf5EHueFzU/+vf+LfTksaTHNeDgyFmlDchIRFueVTe
 np46R07CrQETTvX4PrfvpwGVhAVyKLgACyXr/dlmyRyyp+dUSjXyebwne0nL3dnozeJN
 pbCwj8I0fPluDjjOSpFm4ET1T+7T9gi0aziJORIw6u1CzwHNYsKMF8v00hsR8CXu5+Zo
 cepx7pvgqE1XLOdDhd4EkZr+g6uvrlvPoGUApreJ2DCccoX2k2ZVr1UjbxH3Bn/I6v7v
 3iQg==
Date: Thu, 23 Apr 2020 17:05:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200423170521.65a3bc59@hermes.lan>
In-Reply-To: <20181116165001.30896-1-nikolay@cumulusnetworks.com>
References: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
 <20181116165001.30896-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

On Fri, 16 Nov 2018 18:50:01 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Syzbot reported a use-after-free of the global vlan context on port vlan
> destruction. When I added per-port vlan stats I missed the fact that the
> global vlan context can be freed before the per-port vlan rcu callback.
> There're a few different ways to deal with this, I've chosen to add a
> new private flag that is set only when per-port stats are allocated so
> we can directly check it on destruction without dereferencing the global
> context at all. The new field in net_bridge_vlan uses a hole.
> 
> v2: cosmetic change, move the check to br_process_vlan_info where the
>     other checks are done
> v3: add change log in the patch, add private (in-kernel only) flags in a
>     hole in net_bridge_vlan struct and use that instead of mixing
>     user-space flags with private flags
> 
> Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
> Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Why not just use v->stats itself as the flag.
Since free of NULL is a nop it would be cleaner?
