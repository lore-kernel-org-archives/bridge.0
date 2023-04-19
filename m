Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 235BC61698
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFFC161672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681915887; x=1684507887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RjstvdYGMUmwl7cuoyXhYmHvHwi1+kSblwe4AfO4hek=;
 b=S72bQ216c1qdQUkdu/+jPjWWX97Yo8PU2hHNUcu4JxwHcSouaiZzG7iMmqshjym9Fy
 Ua1d59+VZ6TmuTy3QqRTzwEj2PVoBsGzIIP3Hg1WZvkDBC1x/xQhXN3MBwa6hkM6G04l
 +cnDmHizyTZMlbsYbGfyRDXDmVm1dDuYTM+n1lAuSROUW0uIoKgeQCpLjMtsoA4rVvp6
 e0b9ozjgsK1en+uy8C4aTVWVQrxXSccdmgkfEsDDpnufegsXK91iHrWWH7MO5KurRPew
 0rPGsn4KIBdKAVIJwt6Hzmem3/iXs+w9RyGe2YSR4TUII736yF7/WmOq2/+qRAn+uAWS
 vapQ==
Date: Wed, 19 Apr 2023 17:51:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20230419145124.5z47v2p62nbskqr2@skbuf>
References: <20230413095830.2182382-1-idosch@nvidia.com>
 <95a773f6-5f88-712e-c494-9414d7090144@blackwall.org>
 <ZD/z2vI5ab0zPdRf@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD/z2vI5ab0zPdRf@shredder>
Subject: Re: [Bridge] [RFC PATCH net-next 0/9] bridge: Add per-{Port,
 VLAN} neighbor suppression
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Wed, Apr 19, 2023 at 04:59:54PM +0300, Ido Schimmel wrote:
> On Wed, Apr 19, 2023 at 03:30:07PM +0300, Nikolay Aleksandrov wrote:
> > For the set:
> > Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Thanks! Will rebase, retest and submit v1

Shouldn't the version numbers be independent of the RFC/PATCH
designation (and thus this would be a v2)? I know I was extremely
confused when I had to review a series by Colin Foster which jumped back
and forth between PATCH v6, RFC v3, PATCH v7, etc.
