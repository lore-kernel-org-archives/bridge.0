Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70D506108A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCA4660E2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678797355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRDlS0P57tUZ82YucMyjb9yALmixnNO4XP3+ZIPkZpQ=;
 b=yOVDg75vY/65TxnKwGr91dyQ6ubhO4dnzBkY6+pEAutKm7ZYJ1OSllF6vx44oWrNS0
 Msr/B62sTki6UejCYczVpldvSqOt/lId7MUQupMMxW6SC3EnmhTNe2tP3QOqdSsmTyAh
 ARs18LVjaCp3EKweHA7/rqzhlXm1QONtbaraL62RdVEMmZdt5+6d91P9thACNnGMJMCW
 li0guYsHdeIwLzR8xDnyeZOMycuB+/dWS+I0gs9wumoWwK4FMT5RiJSiOMjzxzWx06tf
 D9yL1QSYm+2l/DxHMjz9QeMkaN5IwLMar0gwWrAyXhkfAofM9RqXT4jUH5omoDF/vcqn
 84Aw==
Message-ID: <4368c837-8474-858e-90ea-e409d08bf84c@blackwall.org>
Date: Tue, 14 Mar 2023 14:35:53 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-12-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-12-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 11/11] selftests: net: Add VXLAN MDB
	test
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Add test cases for VXLAN MDB, testing the control and data paths. Two
> different sets of namespaces (i.e., ns{1,2}_v4 and ns{1,2}_v6) are used
> in order to test VXLAN MDB with both IPv4 and IPv6 underlays,
> respectively.
> 
> Example truncated output:
> 
>  # ./test_vxlan_mdb.sh
>  [...]
>  Tests passed: 620
>  Tests failed:   0
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v1:
>     * New patch.
> 
>  tools/testing/selftests/net/Makefile          |    1 +
>  tools/testing/selftests/net/config            |    1 +
>  tools/testing/selftests/net/test_vxlan_mdb.sh | 2318 +++++++++++++++++
>  3 files changed, 2320 insertions(+)
>  create mode 100755 tools/testing/selftests/net/test_vxlan_mdb.sh
> 

Wohoo, nice!
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
