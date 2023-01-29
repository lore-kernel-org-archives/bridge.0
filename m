Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 714BC4032E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC784400F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqgkF38GQImRFpT8l0bOcZbRmQDjRs1Al/kqBAXFHTo=;
 b=dK75uQOO1cNpYPDE6GEY6mNreQC86/sFydc4f1X2NgUKMgHZLZeeQr3Jtc12nOZOav
 1OYl6Sj+zvONqzYphvS5TbyxQKXioaec7SxOB+rqUBkDzuXFtazvcR9a7goCUHYn5DHD
 UvhZGthalHhwAPjSr7rgxn2H2EOIhelGXhpxuZ/3fgEZfzlsoEC9LD1GxySQJ9LYSL+J
 dWAnrZeBlj9Lby95PGzc1auMe0Y2YcZ5DgchS8qjRmdHyjm4Mi3ieGt+Em/Kdfl58SLW
 bIm4vFUaWGNAgEFMS9zTg3x2OiYhQhj9f9LYJbxw8r1AZuUnI4CQFNQO/6nJWA+nFl5c
 xtRA==
Message-ID: <feafb8fa-d0dc-57b6-d126-4944b2240775@blackwall.org>
Date: Sun, 29 Jan 2023 12:08:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <c3f7ba006ca61292dba6d6389f30a38a70731a8e.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c3f7ba006ca61292dba6d6389f30a38a70731a8e.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 09/16] selftests: forwarding: Move
 IGMP- and MLD-related functions to lib
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 26/01/2023 19:01, Petr Machata wrote:
> These functions will be helpful for other testsuites as well. Extract them
> to a common place.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../selftests/net/forwarding/bridge_mdb.sh    | 49 -------------------
>  tools/testing/selftests/net/forwarding/lib.sh | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 49 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


