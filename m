Return-Path: <skhan@linuxfoundation.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TIOIhGACo4yRcpICfvsrQ9RUZoszNIPIS4XTNvXi2Qw=;
 b=MZB986Q5OSMTg2q6+FUc1U94/pExFm35n39q13oWTNYdQROdXMFcoR99fsh8mRRgjF
 NPE7EENmDHROij227U77hwGmuLHZIZn+6OnB3gCcog4VeC1F3yAJrZC+lUeX3GlZGpMo
 SZPkWb9QoKj+nf3PyOEkJMnyHVAGE3Vr0NL3M=
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0afb9bb6-e8fd-71ce-7626-1d8bf90dd1e4@linuxfoundation.org>
Date: Fri, 18 Feb 2022 14:02:49 -0700
MIME-Version: 1.0
In-Reply-To: <20220218155148.2329797-6-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 5/5] selftests: forwarding: tests
 of locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 2/18/22 8:51 AM, Hans Schultz wrote:
> These tests check that the basic locked port feature works, so that no 'host'
> can communicate (ping) through a locked port unless the MAC address of the
> 'host' interface is in the forwarding database of the bridge.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>   .../testing/selftests/net/forwarding/Makefile |   1 +
>   .../net/forwarding/bridge_locked_port.sh      | 174 ++++++++++++++++++
>   tools/testing/selftests/net/forwarding/lib.sh |  16 ++
>   3 files changed, 191 insertions(+)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> 
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index 72ee644d47bf..8fa97ae9af9e 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0+ OR MIT
>   
>   TEST_PROGS = bridge_igmp.sh \
> +	bridge_locked_port.sh \
>   	bridge_port_isolation.sh \
>   	bridge_sticky_fdb.sh \
>   	bridge_vlan_aware.sh \

Looks good to me. Looks like TEST_PROGS # is getting close to 60.
Cool.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
