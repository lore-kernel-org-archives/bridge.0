Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Gkv/Enp/IZmxcfofAOCjTBnszxX0aQMOLZxHcfoa6sI=;
 b=cjd3KI2i21VdxnTAX1vYFQv6InII+4UIOpRkW0Ttkn25FiUgiZzihokuoLn2u36vWj
 Q3ZcqOqeG+xvuevBbHaGOQjtlM2kZlqMXQpfmCDp5+BFaBIovgfjJvWYTBm+/abwkyMC
 sUF1AnOXneFlisQihQI5QzuITbgQNp7MbxSJL4CGsdoiW5ou4V6EYBz7zzaswNhIebRI
 McrLmmO5VoNznl/5PtHFYtSFS3d99FUJFBMnrbl6JezgidCYPNegRQWJuRtlu+OB+qbp
 xuqAjvzNLJAB8ow04SzHI9MIY4q6hESh0kWlvf0iPg0fSciu0AY/dbli7YUz3IjbpgnT
 irdQ==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <20220318131943.hc7z52beztqlzwfq@skbuf>
References: <86lex9hsg0.fsf@gmail.com> <YjNDgnrYaYfviNTi@lunn.ch>
 <20220317153625.2ld5zgtuhoxbcgvo@skbuf> <86ilscr2a4.fsf@gmail.com>
 <20220317161808.psftauoz5iaecduy@skbuf> <8635jg5xe5.fsf@gmail.com>
 <20220317172013.rhjvknre5w7mfmlo@skbuf> <86tubvk24r.fsf@gmail.com>
 <20220318121400.sdc4guu5m4auwoej@skbuf> <86pmmjieyl.fsf@gmail.com>
 <20220318131943.hc7z52beztqlzwfq@skbuf>
Date: Tue, 22 Mar 2022 12:01:13 +0100
Message-ID: <86a6dixnd2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On fre, mar 18, 2022 at 15:19, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Fri, Mar 18, 2022 at 02:10:26PM +0100, Hans Schultz wrote:
>> In the offloaded case there is no difference between static and dynamic
>> flags, which I see as a general issue. (The resulting ATU entry is static
>> in either case.)
>
> It _is_ a problem. We had the same problem with the is_local bit.
> Independently of this series, you can add the dynamic bit to struct
> switchdev_notifier_fdb_info and make drivers reject it.
>
>> These FDB entries are removed when link goes down (soft or hard). The
>> zero DPV entries that the new code introduces age out after 5 minutes,
>> while the locked flagged FDB entries are removed by link down (thus the
>> FDB and the ATU are not in sync in this case).
>
> Ok, so don't let them disappear from hardware, refresh them from the
> driver, since user space and the bridge driver expect that they are
> still there.

I have now tested with two extra unmanaged switches (each connected to a
seperate port on our managed switch, and when migrating from one port to
another, there is member violations, but as the initial entry ages out,
a new miss violation occurs and the new port adds the locked entry. In
this case I only see one locked entry, either on the initial port or
later on the port the host migrated to (via switch).

If I refresh the ATU entries indefinitly, then this migration will for
sure not work, and with the member violation suppressed, it will be
silent about it.

So I don't think it is a good idea to refresh the ATU entries
indefinitely.

Another issue I see, is that there is a deadlock or similar issue when
receiving violations and running 'bridge fdb show' (it seemed that
member violations also caused this, but not sure yet...), as the unit
freezes, not to return...
