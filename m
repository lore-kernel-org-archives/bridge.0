Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EB6E404FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5576D400A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBOGF8+aet6XcQembZ/mMbGiUrwTsb/R0mIXWdywGsE=;
 b=U+7fQMoWLlhqaTZGAW0g4SnUl4nQ4T8TVBumgF7yS+KLEJxHgU9B3F9C6SO1isw457
 EVxECdeUWqt+HX5Udad4fXM3XoCFElfc05/QzucjaaFpJNZgEZO+l7EavOPLmSwy3Z7U
 PZsWVpkwQkGBy1W5+P5rSuqSx1dhf383iw2ayVrfCaGRsGteCzDIjsEKmRDdzeDOb2oN
 AcGMppgg0Z+F4pRERQv9t2NcNa+onaWUWApajFJYkEU05BaWOqjZIuT4r3gFjcAtYX4/
 VCmbKxFS6fTQa5yu3LM/0lvTHDM/TLeC+YAUPZgHH2R7rtq95hStR7/AGsmpYEHRAzci
 MwSA==
Message-ID: <73405dec-e1ec-e581-ba8e-83bb8343d2b0@blackwall.org>
Date: Mon, 5 Dec 2022 13:55:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20221205074251.4049275-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20221205074251.4049275-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/8] bridge: mcast: Preparations for
 EVPN extensions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 05/12/2022 09:42, Ido Schimmel wrote:
> This patchset was split from [1] and includes non-functional changes
> aimed at making it easier to add additional netlink attributes later on.
> Future extensions are available here [2].
> 
> The idea behind these patches is to create an MDB configuration
> structure into which netlink messages are parsed into. The structure is
> then passed in the entry creation / deletion call chain instead of
> passing the netlink attributes themselves. The same pattern is used by
> other rtnetlink objects such as routes and nexthops.
> 
> I initially tried to extend the current code, but it proved to be too
> difficult, which is why I decided to refactor it to the extensible and
> familiar pattern used by other rtnetlink objects.
> 
> Tested using existing selftests and using a new selftest that will be
> submitted together with the planned extensions.
> 
> No changes since initial RFC.
> 
> [1] https://lore.kernel.org/netdev/20221018120420.561846-1-idosch@nvidia.com/
> [2] https://github.com/idosch/linux/commits/submit/mdb_v1
> 
> Ido Schimmel (8):
>   bridge: mcast: Centralize netlink attribute parsing
>   bridge: mcast: Remove redundant checks
>   bridge: mcast: Use MDB configuration structure where possible
>   bridge: mcast: Propagate MDB configuration structure further
>   bridge: mcast: Use MDB group key from configuration structure
>   bridge: mcast: Remove br_mdb_parse()
>   bridge: mcast: Move checks out of critical section
>   bridge: mcast: Remove redundant function arguments
> 
>  net/bridge/br_mdb.c     | 312 +++++++++++++++++++---------------------
>  net/bridge/br_private.h |   7 +
>  2 files changed, 156 insertions(+), 163 deletions(-)
> 

As I also commented on the RFC, nice work! Allowing user-space to manipulate and manually
install such entries is a natural extension.

One thought (not a big deal) but it would've been ideal if we could initialize the config
struct once when parsing and then pass it around as a const argument. I know that its
arguments are currently passed to functions that don't expect const, but I *think* it
could be a small change.

Thanks,
 Nik

