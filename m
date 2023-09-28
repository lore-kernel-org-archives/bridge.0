Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 835126111F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42C7C60F88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695904556; x=1696509356;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPk2ZzrID8Ruy/e6ubyOdQXDCXqUez+jUlvGZE9CHoc=;
 b=pU/9Ly4920tGnk+JMFchvVfPAyrPS+m8kTkcWqnOs/uiCIltU1RL2Dnb2lqwQzTvWq
 7MFOB9thJPwwQrWwYqV9MNPcP5zoky4mfYM4VIGqv4zVRuUdmQMaoxcBMNyKTrJFj5uA
 C5QWZcvmvnL9Z9wQeRfnlQM6AvKUnnKJmUodnLakFjKeTHYMOCiwHO6pgG/i7D2Z9DT8
 EgeJIVAFczZTh2BTIH8bydWN4x/v82AnPNtcTKGAOOpqQVdiRPmpCtzy/WkToDXfztg3
 0f0DnCkFYP3mvJoV//n+xGOeHf5f/2O15xU0NykmivoYFM3h61PGeqSxtUbNNiBeSkR2
 yxoA==
Message-ID: <2c985516-88a3-9fee-dbd1-134aecd323e5@blackwall.org>
Date: Thu, 28 Sep 2023 15:35:53 +0300
MIME-Version: 1.0
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
References: <20230927075713.1253681-1-trent.lloyd@canonical.com>
 <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
In-Reply-To: <3dccacd8-4249-87f8-690c-6083374dc9d1@blackwall.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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

On 9/27/23 11:10, Nikolay Aleksandrov wrote:
> On 9/27/23 10:57, Trent Lloyd wrote:
>> Commit 804b854d374e ("net: bridge: disable bridge MTU auto tuning if it
>> was set manually") disabled auto-tuning of the bridge MTU when the MTU
>> was explicitly set by the user, however that would only happen when the
>> MTU was set after creation. This commit ensures auto-tuning is also
>> disabled when the MTU is set during bridge creation.
>>
>> Currently when the br_netdev_ops br_change_mtu function is called, the
>> flag BROPT_MTU_SET_BY_USER is set. However this function is only called
>> when the MTU is changed after interface creation and is not called if
>> the MTU is specified during creation with IFLA_MTU (br_dev_newlink).
>>
>> br_change_mtu also does not get called if the MTU is set to the same
>> value it currently has, which makes it difficult to work around this
>> issue (especially for the default MTU of 1500) as you have to first
>> change the MTU to some other value and then back to the desired value.
>>
> 
> Yep, I think I also described this in the commit message of my patch.
> 
>> Add new selftests to ensure the bridge MTU is handled correctly:
>>   - Bridge created with user-specified MTU (1500)
>>   - Bridge created with user-specified MTU (2000)
>>   - Bridge created without user-specified MTU
>>   - Bridge created with user-specified MTU set after creation (2000)
>>
>> Regression risk: Any workload which erroneously specified an MTU during
>> creation but accidentally relied upon auto-tuning to a different value
>> may be broken by this change.
>>
> 
> Hmm, you're right. There's a risk of regression. Also it acts 
> differently when set to 1500 as you've mentioned. I think they should 
> act the same, also bridge's fake rtable RTAX_MTU is not set.
> 
>> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2034099
>> Fixes: 804b854d374e ("net: bridge: disable bridge MTU auto tuning if 
>> it was set manually")
>> Signed-off-by: Trent Lloyd <trent.lloyd@canonical.com>
>> ---
> 

So I've been thinking about this and to elaborate - my concerns are two
first is inconsistency between setting MTU at create vs later when it's 
the default (i.e. this way disables auto-tuning, while later it doesn't)
and second is potential breakage as some network managers always set the 
mtu when creating devices. That would suddenly start disabling 
auto-tuning and that will surprise some people which expect it to work.

I think if you make them both act the same and leave out that case with 
a big comment why, this would be good for -net. To fully solve the 
problem without breaking anyone I think we should add control over the 
autotuning flag so it can be turned on/off by the users. That would be 
explicit and will work for all cases, but that is net-next material.

Thanks,
  Nik

