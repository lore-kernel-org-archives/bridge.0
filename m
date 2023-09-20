Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7455A41DBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E67241BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695207672; x=1695812472;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fFCnzCVFLsbuhvtZ9EHw9SNjPT4ld8559k/OSp8m+oI=;
 b=hSYhlYhJW38iCWXGL0adIs9wqFItoIU/7fJKfZ07yY6PsKZGrPfSl+ZwvmSjLv/R9H
 Nd1TwzqekEWvgq3m2O0EA3V+OyOIRxdt3IsUq3MU4+Sbs9Wx+wS/e0iJ09oxalu59YqL
 KFrs0AoC6RtJOJRNiN0ef3o9XJ3EGRAKJBEAw0qjsKnPMiSjXAn56GA/P7x9ofi0mWhM
 PL9jwanzXtuwA60BUEWh6ZG84IErxouAZlMH1/cDZlZD7FJcUbktkPZOau2MlxT5zZRE
 rJd6YkD2lsZzheG44zi0BEYROpsUrmRWjmaIfu6tE59Wn1uUo9lDOiSbiQMWrw9BZaJC
 Y3Tg==
Message-ID: <e1c0f5ac-a0bc-dc2c-0638-c580498670e4@blackwall.org>
Date: Wed, 20 Sep 2023 14:01:10 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-6-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 6/6] selftests: forwarding:
 bridge_fdb_learning_limit: Add a new selftest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> Add a suite covering the fdb_n_learned and fdb_max_learned bridge
> features, touching all special cases in accounting at least once.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   tools/testing/selftests/net/forwarding/Makefile    |   3 +-
>   .../net/forwarding/bridge_fdb_learning_limit.sh    | 283 +++++++++++++++++++++
>   2 files changed, 285 insertions(+), 1 deletion(-)
> 

Always nice to see new tests. Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


