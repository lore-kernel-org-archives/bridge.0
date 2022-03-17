Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dn5WetjsAweDFdDrV
 E4l3jAwTI6fbXOJu2TtvBSryHA=; b=LPpPYa+uaec9c9tSWDa/a1qlX0DXYY3jS
 RzshbqmdO7dVF5xENoH4gUmkN1VmVq71AeGh5/2aKK3C3/wkIQ3ltbJ3zZ3ZNI0q
 RCzcsWxvFuG2hNRV9pgsfdRmzrFDnPUMZqmgKSF9/pD5PDg9Mc9rS7x5iCccEqFt
 RWORpzNXsgm1ZJuULqEpBFfmU6cjr7dYAHL8lNt5o7Ew26AISo6jHxUpdUYb2+Y7
 kHivUhf54VhAKl40e7KSIMzPOlUsMHx9xNm2VB073ZQbUKxcIiI3QJoWjkCrQm8W
 V0fLprnZFEnyIdy86Tnd0+8u7nTPvEfOsHnBUgEctlov3U1h2LCYA==
Date: Thu, 17 Mar 2022 16:57:15 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YjNMS6aFG+93ejj5@shredder>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-5-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317093902.1305816-5-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 4/4] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Mar 17, 2022 at 10:39:02AM +0100, Hans Schultz wrote:
> Verify that the MAC-Auth mechanism works by adding a FDB entry with the
> locked flag set. denying access until the FDB entry is replaced with a
> FDB entry without the locked flag set.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  .../net/forwarding/bridge_locked_port.sh      | 29 ++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> index 6e98efa6d371..2f9519e814b6 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_locked_port.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> -ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan"
> +ALL_TESTS="locked_port_ipv4 locked_port_ipv6 locked_port_vlan locked_port_mab"
>  NUM_NETIFS=4
>  CHECK_TC="no"
>  source lib.sh
> @@ -170,6 +170,33 @@ locked_port_ipv6()
>  	log_test "Locked port ipv6"
>  }
>  
> +locked_port_mab()
> +{
> +	RET=0
> +	check_locked_port_support || return 0
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work before locking port"
> +
> +	bridge link set dev $swp1 locked on
> +	bridge link set dev $swp1 learning on
> +
> +	ping_do $h1 192.0.2.2
> +	check_fail $? "MAB: Ping worked on port just locked"
> +
> +	if ! bridge fdb show | grep `mac_get $h1` | grep -q "locked"; then
> +		RET=1
> +		retmsg="MAB: No locked fdb entry after ping on locked port"
> +	fi

bridge fdb show | grep `mac_get $h1 | grep -q "locked"
check_err $? "MAB: No locked fdb entry after ping on locked port"

> +
> +	bridge fdb del `mac_get $h1` dev $swp1 master
> +	bridge fdb add `mac_get $h1` dev $swp1 master static

bridge fdb replace `mac_get $h1` dev $swp1 master static

> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
> +
> +	log_test "Locked port MAB"

Clean up after the test to revert to initial state:

bridge fdb del `mac_get $h1` dev $swp1 master
bridge link set dev $swp1 locked off


> +}
>  trap cleanup EXIT
>  
>  setup_prepare
> -- 
> 2.30.2
> 
