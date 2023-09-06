Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE8608176B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4770E813EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6h3CdCR32rD2K1EUffRq6loThkZ3P48GIGqQxAcE8I=;
 b=odCclGV8JYi3Hnt/Qw9engq9DD0UyAjDMplkqpTToBbyysdSH3vQJC4Ignx3cnbG09KWP/MuC8JHhcTNcEVR/N/EN5bLZa0Ov24I8vFzGcRun4RtqfFqDL9plvQins2bWxxJNn3rZ+ADc8h/EzvxkX9E8a5UUygvSyWhlikAzL5i1NOBRLDVirzYPse2Juw3cJIAN8L027fgwRRIFESP6zSESOhADBS7ZynEiPHxf09ySUiqRYcveUSD4UzUnQD5vJpdJO1Bui1LpHsc2uokh9Qtp5+O+YfvLaKap11YA3t4f99s+28vZR82ykQtX3HvxxCUNPwJdVVMwnsywMP4jg==
References: <20230905-fdb_limit-v3-1-34bb124556d8@avm.de>
From: Petr Machata <petrm@nvidia.com>
Date: Wed, 6 Sep 2023 12:32:32 +0200
In-Reply-To: <20230905-fdb_limit-v3-1-34bb124556d8@avm.de>
Message-ID: <87msxzmv5q.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH iproute2-next v3] iplink: bridge: Add support
 for bridge FDB learning limits
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

(I pruned the CC list, hopefully I didn't leave out anybody who cares.)

Johannes Nixdorf via Bridge <bridge@lists.linux-foundation.org> writes:

> Support setting the FDB limit through ip link. The arguments is:
>  - fdb_max_learned_entries: A 32-bit unsigned integer specifying the
>                             maximum number of learned FDB entries, with 0
>                             disabling the limit.

...

> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Code looks good to me. A couple points though:

- The corresponding kernel changes have not yet been merged, have they?
  This patch should obviously only be merged after that happens.

- The UAPI changes should not be part of the patch, the maintainers will
  update themselves.

- The names fdb_n_learned_entries, fdb_max_learned_entries... they are
  somewhat unwieldy IMHO. Just for consideration, I don't feel strongly
  about this:

  Your kconfig option is named BRIDGE_DEFAULT_FDB_MAX_LEARNED, and that
  makes sense to me, because yeah, given the word "learned" in context
  of FDB, "entries" is the obvious continuation, so why mention it
  explicitly. Consider following suit with the other source artifacts --
  the attribute names, struct fields, keywords in this patch.
  "fdb_n_learned", "fdb_max_learned" is IMHO just as understandable and
  will be easier to type.
