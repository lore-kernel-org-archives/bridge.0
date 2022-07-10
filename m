Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C86D040407
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3ED44011C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpdOBL9jWUSDIIFENbhIXamlr7yKqFmD2i2SamZ3vkk=;
 b=f8TZEGrYl4qAR6sZTjruOnHmew/f9tZLuGAuiGiNSj0nhG6/wZaR9404lYcibh+Ml3oygT8T03Rh9/2TW8JPDmpC1Ukh0qbKD0AbiuSg0JEfgGmSI3BevM5gVmJOK3hRfP562Ukg5MMUlDZMkdHzf8sCRY+GSOIX/x9jjDQlpqrlSpoqffqpDQppu3dc0dGK7Vh6HYRGP7hVrdkhD39FwAs0haBUzoauo48wOhh5ooNkOwEMnra14d7HwCEJw4PGhBUlvj+CPOnnuf98ulXztie28RpYgsR25TM5KDbazCiyJWh+N7lWmfHw7aA8WPlyp5gNXL1ST8opz5E2TMk28w==
Date: Sun, 10 Jul 2022 10:29:26 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Ysp/1k6uwcmJIon0@shredder>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
 <20220707152930.1789437-7-netdev@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707152930.1789437-7-netdev@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Thu, Jul 07, 2022 at 05:29:30PM +0200, Hans Schultz wrote:
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

I was under the impression that we agreed that learning does not need to
be enabled in the bridge driver

> +
> +	ping_do $h1 192.0.2.2
> +	check_fail $? "MAB: Ping worked on locked port without FDB entry"
> +
> +	bridge fdb show | grep `mac_get $h1` | grep -q "locked"
> +	check_err $? "MAB: No locked fdb entry after ping on locked port"
> +
> +	bridge fdb replace `mac_get $h1` dev $swp1 master static
> +
> +	ping_do $h1 192.0.2.2
> +	check_err $? "MAB: Ping did not work with fdb entry without locked flag"
> +
> +	bridge fdb del `mac_get $h1` dev $swp1 master
> +	bridge link set dev $swp1 learning off
> +	bridge link set dev $swp1 locked off
> +
> +	log_test "Locked port MAB"
> +}
>  trap cleanup EXIT
>  
>  setup_prepare
> -- 
> 2.30.2
> 
