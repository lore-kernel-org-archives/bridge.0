Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E48741058
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC32D401D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1z40xBZl1s88AVKBaaMT4kPg0/IWGeDII88qOAQgOrM=;
 b=ugJ1ZUxXgqF6M2ADHF0b7CSoiPxc2idiHZ2fRCEKjinDPuJE2buPQtrAgjDPb3eklH
 yExCa7ATGFczL1g330HeaNsvJYxp3uMmFmpgZ5scL1Gv8BDXq+CM8vi+Yy6zCybrbEE1
 yvEnkc+NXR+ivXGx61+N8VusLuYKcwoRKlBJC2qLYRuGCA8ylN4rd7Dusa8F29f1tkss
 DATUANszgU8rquTfwekSlBTrURvimxxPLYMUDnzTjX3g9e5taFjOLQuY2fUcQVY5dnv2
 8vAW/OmHtlY200qBn0iNM/CgVbxDZ8ErDa3qfQMqjybVpO87MwGol2ISPhewfHnDAgQO
 wz/Q==
Message-ID: <6e50c1ac-9182-0d86-24fb-afcc2c63db85@blackwall.org>
Date: Fri, 3 Feb 2023 10:58:12 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1675359453.git.petrm@nvidia.com>
 <a01c188bcbbb0f5f53e333ed9175f938eb2736be.1675359453.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a01c188bcbbb0f5f53e333ed9175f938eb2736be.1675359453.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 06/16] net: bridge: Add a
 tracepoint for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org

On 02/02/2023 19:59, Petr Machata wrote:
> The following patch will add two more maximum MDB allowances to the global
> one, mcast_hash_max, that exists today. In all these cases, attempts to add
> MDB entries above the configured maximums through netlink, fail noisily and
> obviously. Such visibility is missing when adding entries through the
> control plane traffic, by IGMP or MLD packets.
> 
> To improve visibility in those cases, add a trace point that reports the
> violation, including the relevant netdevice (be it a slave or the bridge
> itself), and the MDB entry parameters:
> 
> 	# perf record -e bridge:br_mdb_full &
> 	# [...]
> 	# perf script | cut -d: -f4-
> 	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00 vid 0
> 	 dev v2 af 10 src :: grp ff0e::112/00:00:00:00:00:00 vid 0
> 	 dev v2 af 2 src ::ffff:0.0.0.0 grp ::ffff:239.1.1.112/00:00:00:00:00:00 vid 10
> 	 dev v2 af 10 src 2001:db8:1::1 grp ff0e::1/00:00:00:00:00:00 vid 10
> 	 dev v2 af 2 src ::ffff:192.0.2.1 grp ::ffff:239.1.1.1/00:00:00:00:00:00 vid 10
> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Notes:
>     v2:
>     - Report IPv4 as an IPv6-mapped address through the IPv6 buffer
>       as well, to save ring buffer space.
> 
>  include/trace/events/bridge.h | 58 +++++++++++++++++++++++++++++++++++
>  net/core/net-traces.c         |  1 +
>  2 files changed, 59 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


