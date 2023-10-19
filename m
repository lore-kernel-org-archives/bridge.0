Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 085A66FA2E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 212C36FA2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkQljl9YXTzUNjyCU+BBoU8goswv4g544fi0YEtVCWI=;
 b=B0Ie6D8s7F3WGLT8vNY0aSdn75ddJYQ2Nrg327r0K7lWwZyPGotQ+3Lcu3+SxXclRASQwFX/c41A4WVwMiImBzoVVTlgXFodNRZ5S0agRCimTxa1qrSYlSVRWL813ktLw/lLi7TIWZ2A4D4cJYYZOsH+3k3jjxcWe3G6NfE1EVrrQxLbwg9jlWfSazqnszQAbrRVXImjxun1LPzYB2klRLHmz6C27HJFP0B032YhOhJByZJumVWos65QOK2p2dNqBzybq85gkh2JUm8cko5MkE56FyHyAQNlkZbc/met9eXg6O0jfLzpEUADkm9FFNWnrJQRzgeQjEL1i+fJ8m2nEQ==
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
From: Petr Machata <petrm@nvidia.com>
Date: Thu, 19 Oct 2023 11:50:21 +0200
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
Message-ID: <87il730wkx.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH iproute2-next v5] iplink: bridge: Add support
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
Cc: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>


Johannes Nixdorf <jnixdorf-oss@avm.de> writes:

> Support setting the FDB limit through ip link. The arguments is:
>  - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                     number of learned FDB entries, with 0 disabling
>                     the limit.
>
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>  - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                   of learned FDB entries.
>
> Example:
>
>  # ip -d -j -p link show br0
> [ {
> ...
>         "linkinfo": {
>             "info_kind": "bridge",
>             "info_data": {
> ...
>                 "fdb_n_learned": 2,
>                 "fdb_max_learned": 0,
> ...
>             }
>         },
> ...
>     } ]
>  # ip link set br0 type bridge fdb_max_learned 1024
>  # ip -d -j -p link show br0
> [ {
> ...
>         "linkinfo": {
>             "info_kind": "bridge",
>             "info_data": {
> ...
>                 "fdb_n_learned": 2,
>                 "fdb_max_learned": 1024,
> ...
>             }
>         },
> ...
>     } ]
>
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Petr Machata <petrm@nvidia.com>
