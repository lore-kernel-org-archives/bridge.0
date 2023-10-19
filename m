Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8746C401F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEE1040190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697721152; x=1698325952;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1QQy/TzuYABfNuKOiHX44LqVgl9CKlKEp054v57jP8=;
 b=aciUkdUT0uWZj8zKG2uV58j7JgqgHKl0Qs3dFlsYbsxAmfRH8TzaBJHJEbTlU17ILF
 qTL5ldejPjGdqtliNf/XzA9DovA5rFknNLtLnOA+D49Nxthl+2nz1wapZQbvS/p0u9Vc
 uaeobLN55mTE2/vG8I/oUzw3lKLCn4dyTkEZreDcHSFDs1TdO5wsxwg136h0GjU+luqB
 1YQJSQve9MWcH3MNw7KxwtWrV7icnqy/cnaMJxGOJN0uu2axmkXHn6CrnuYknOyChXzF
 Sr1fHvXO3DlMC+l43xxib+ixD5rV+efOCGi9JctZKfQJOjF/TCFSGbeF6Gn2Rv+5jiyN
 WVow==
Message-ID: <632c55ba-9adb-8afb-3558-94ea5f0168f8@blackwall.org>
Date: Thu, 19 Oct 2023 16:12:29 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 10/18/23 10:04, Johannes Nixdorf wrote:
> Support setting the FDB limit through ip link. The arguments is:
>   - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                      number of learned FDB entries, with 0 disabling
>                      the limit.
> 
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>   - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                    of learned FDB entries.
> 
> Example:
> 
>   # ip -d -j -p link show br0
> [ {
> ...
>          "linkinfo": {
>              "info_kind": "bridge",
>              "info_data": {
> ...
>                  "fdb_n_learned": 2,
>                  "fdb_max_learned": 0,
> ...
>              }
>          },
> ...
>      } ]
>   # ip link set br0 type bridge fdb_max_learned 1024
>   # ip -d -j -p link show br0
> [ {
> ...
>          "linkinfo": {
>              "info_kind": "bridge",
>              "info_data": {
> ...
>                  "fdb_n_learned": 2,
>                  "fdb_max_learned": 1024,
> ...
>              }
>          },
> ...
>      } ]
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
> The corresponding kernel changes are in net-next.git as commit
> ddd1ad68826d ("net: bridge: Add netlink knobs for number / max learned
> FDB entries").
> ---
> Changes in v5:
>   - Removed the RFC status again, as the kernel changes landed.
>   - Link to v4: https://lore.kernel.org/r/20230919-fdb_limit-v4-1-b4d2dc4df30f@avm.de
> 
> Changes in v4:
>   - Removed _entries from the names. (from review)
>   - Removed the UAPI change, to be synced from linux separately by the
>     maintainer. (from review)
>     For local testing e.g. `make CCOPTS="-O2 -pipe
>     -I${path_to_dev_kernel_headers}"` works as a workaround.
>   - Downgraded to an RFC until the kernel changes land.
>   - Link to v3: https://lore.kernel.org/netdev/20230905-fdb_limit-v3-1-34bb124556d8@avm.de/
> 
> Changes in v3:
>   - Properly split the net-next and iproute2-next threads. (from review)
>   - Changed to *_n_* instead of *_cur_*. (from review)
>   - Use strcmp() instead of matches(). (from review)
>   - Made names in code and documentation consistent. (from review)
>   - Various documentation fixes. (from review)
>   - Link to v2: https://lore.kernel.org/netdev/20230619071444.14625-1-jnixdorf-oss@avm.de/
> 
> Changes in v2:
>   - Sent out the first corresponding iproute2 patches.
>   - Link to v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/
> ---
>   ip/iplink_bridge.c    | 21 +++++++++++++++++++++
>   man/man8/ip-link.8.in | 10 ++++++++++
>   2 files changed, 31 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


