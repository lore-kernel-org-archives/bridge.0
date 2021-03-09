Return-Path: <baijiaju1990@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hzSCIKRAepKDBSqSG3kIFxZmTW4GplrRyROpRrL9fZk=;
 b=VoUC+t+4QQEB+uwm9H46DQTFa9Lxcv65xlBoQILewDayS5eF40i8muFvUZwnMdTwEp
 vndo1PrFpuvtxtttpGyVTXNI7XzW/5br+dEfWiRiPld2yrEHih/GMnxBJmXplP9KNYzu
 0xC0a8SyJu3hpz3MXIFpaAlQgV8QL64PiJYqt9v1CHJTlgW8hgB6KbQ0qOxmv6RFGk2t
 fBxGvLENa4EPpuyVJ+kkUeXFo5rLymW/ZOcZrLKoi8m7DpQus3oAbCYnkEv7CDKeM3d2
 ihIqn6jFUMPv74suxw+3gSNUecSlJs5f6okTzGOy8RLA/2OHV2XB5rXSTkIjfuUMw5vy
 +llw==
References: <20210309022854.17904-1-baijiaju1990@gmail.com>
 <20210309110121.GD10808@breakpoint.cc>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e0f4d41e-b600-ce3b-b2e8-ca5c12f151dc@gmail.com>
Date: Tue, 9 Mar 2021 21:31:39 +0800
MIME-Version: 1.0
In-Reply-To: <20210309110121.GD10808@breakpoint.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Bridge] [PATCH] net: bridge: fix error return code of
 do_update_counters()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kadlec@netfilter.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net, pablo@netfilter.org



On 2021/3/9 19:01, Florian Westphal wrote:
> Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>> When find_table_lock() returns NULL to t, no error return code of
>> do_update_counters() is assigned.
> Its -ENOENT.
>
>>   	t = find_table_lock(net, name, &ret, &ebt_mutex);
>                                         ^^^^^
>
> ret is passed to find_table_lock, which passes it to
> find_inlist_lock_noload() which will set *ret = -ENOENT
> for NULL case.

Thanks for the reply!
I did not notice "&ret" in find_table_lock()...
I am sorry for the false positive.


Best wishes,
Jia-Ju Bai
