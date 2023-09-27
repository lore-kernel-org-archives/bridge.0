Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F4DA40965
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A966C4095E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695802252; x=1696407052;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NBmOuCvdW9NVL1Xq7Sds9uqW+w+rqXLS8qDFF1herE8=;
 b=26Ygd3M1Uzh6WVZGuPaGq32XU0TUF+S762qQ49QF8A+1QaMYUlPPBQjpREDcjVKRln
 A8F+AF9Z2TPPVa5tKZ/xo9Y6ZOUEhxxEgbB8t9y/k1aoR1foA5GCnZ4GYDrbOhQwwFjp
 F6MjT1llNHNOx3s21+Fvp1UUh4yoxtQYDwitHpSFJ/RqVdYK8f7V8LiUrfAJXxWu63cV
 FdUGG9RI7ubKs8+FEzKq4aQZB9WozZBPFiQxZXgdL4XcY7zSu77y7rd00137n4Qz6jOq
 +iDAJf6CPdr2HeGQIiCA6C5CECDvcmBLbyk3N47Y8PA6R5NbwkRsHlZW6JvCltzdSYsw
 7YGw==
Message-ID: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Date: Wed, 27 Sep 2023 11:10:50 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230927075713.1253681-1-trent.lloyd@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: MTU auto tuning ignores IFLA_MTU on
	NEWLINK
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Trent Lloyd <trent.lloyd@canonical.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/27/23 10:57, Trent Lloyd wrote:
> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
> was set manually") disabled auto-tuning of the bridge MTU when the MTU
> was explicitly set by the user, however that would only happen when the
> MTU was set after creation. This commit ensures auto-tuning is also
> disabled when the MTU is set during bridge creation.
> 
> Currently when the br_netdev_ops br_change_mtu function is called, the
> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
> when the MTU is changed after interface creation and is not called if
> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
> 
> br_change_mtu also does not get called if the MTU is set to the same
> value it currently has, which makes it difficult to work around this
> issue (especially for the default MTU of 1500) as you have to first
> change the MTU to some other value and then back to the desired value.
> 

Yep, I think I also described this in the commit message of my patch.

> Add new selftests to ensure the bridge MTU is handled correctly:
>   - Bridge created with user-specified MTU (1500)
>   - Bridge created with user-specified MTU (2000)
>   - Bridge created without user-specified MTU
>   - Bridge created with user-specified MTU set after creation (2000)
> 
> Regression risk: Any workload which erroneously specified an MTU during
> creation but accidentally relied upon auto-tuning to a different value
> may be broken by this change.
> 

Hmm, you're right. There's a risk of regression. Also it acts 
differently when set to 1500 as you've mentioned. I think they should 
act the same, also bridge's fake rtable RTAX_MTU is not set.

> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it was set manually")
> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
> ---

