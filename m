Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=qs/d6eRMsE3W5PauvBIvDHu7IP681Nr7sUF8OehanNA=;
 b=AY5+QQmby5D8nvGvA7iUqTaPU5tTPAIrk1g+XO3Z8dXZ4ra0Zjjmw42wd+4nTl01h9
 aEpnG+VL5SOMivcSneQAYKHQ8COdjSl6fATqvWjadCiAjnLjdpfgjeCi8CBouEMXlcUr
 CI9Adk9z6cLmT5DJ5L2UEd/XnDliz1O0xXDdbFjYSj7v1Ixz/ZjBQlUQyiKC3/d49ZtE
 bmmzQ0LExw2KPzX5dAJtHi1kBjtR23us4tKUujOnDgwWPQl0DfAMZjuIJXPvPXcwCJBA
 swWvDoSO8HSEi0y9hI2k5s1shuEG4WvCnDMn2x4KmQ2zxiOgjavZSXaALtTq51jowkTt
 lW3w==
Message-ID: <b9059a6e-353d-dea0-0d55-27829c8f51ae@blackwall.org>
Date: Wed, 13 Apr 2022 10:27:22 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220412132245.2148794-1-razor@blackwall.org>
 <c418e95e-440e-0502-58f2-63179f370a98@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c418e95e-440e-0502-58f2-63179f370a98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/8] net: bridge: add flush
	filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: idosch@idosch.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 13/04/2022 05:04, David Ahern wrote:
> On 4/12/22 7:22 AM, Nikolay Aleksandrov wrote:
>> Hi,
>> This patch-set adds support to specify filtering conditions for a bulk
>> delete (flush) operation. This version uses a new nlmsghdr delete flag
>> called NLM_F_BULK in combination with a new ndo_fdb_del_bulk op which is
>> used to signal that the driver supports bulk deletes (that avoids
>> pushing common mac address checks to ndo_fdb_del implementations and
>> also has a different prototype and parsed attribute expectations, more
>> info in patch 03). The new delete flag can be used for any RTM_DEL*
>> type, implementations just need to be careful with older kernels which
>> are doing non-strict attribute parses. Here I use the fact that mac
> 
> overall it looks fine to me. The rollout of BULK delete for other
> commands will be slow so we need a way to reject the BULK flag if the
> handler does not support it. One thought is to add another flag to
> rtnl_link_flags (e.g., RTNL_FLAG_BULK_DEL_SUPPORTED) and pass that flag
> in for handlers that handle bulk delete and reject it for others in core
> rtnetlink code.

Good point, it will be nice to error out with something meaningful if
bulk delete isn't supported. I'll look into it.

Thanks,
 Nik

