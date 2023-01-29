Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65F4781345
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0353A8133A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4CsT+NMYktzeydFPAHImkzr8929Eu6j85d9i8GMD/Zk=;
 b=gcT8L98xIM2tz4DFl9Z7r2oIUKwwC/eZt8BCs7XuG9aT99dv1SgOcGFHnIXKJY/mAD
 qNPHKq0iQThy10UVMpv11YjuM1n4xbpFDccX8MoOPCz+ptqOx8uEiKji623v86GMAWOA
 TzuYCaAbnEmkWGvSUsWB9conRzTdgDTtZc2OzowO+AYqhrMvVNugUwitCrJXTp5pwA9c
 C8MR+unp1bAdjRcSj6XiBxu1dfoqNCsMPafoM8HYVFXofxgTD/ZxOmfY/j9kxonPCeGL
 WjXX2x7+U/HsbID1xGMDN4dMZGhbE6vF7fQcqwRkRlMyOp80m0IfJZwo9svh+JDZzIIG
 plWQ==
Message-ID: <273f85f3-0eee-467e-29bb-018b7c0b8fd6@blackwall.org>
Date: Sun, 29 Jan 2023 12:09:47 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <cc8762f78b2468f9b48288235470bd606fddbd96.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cc8762f78b2468f9b48288235470bd606fddbd96.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 11/16] selftests: forwarding: lib: Add
 helpers for IP address handling
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
> In order to generate IGMPv3 and MLDv2 packets on the fly, we will need
> helpers to expand IPv4 and IPv6 addresses given as parameters in
> mausezahn payload notation. Add helpers that do it.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
